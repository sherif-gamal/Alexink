class MaterialsController < ApplicationController
  before_action :set_material, only: [:show, :edit, :update, :destroy]

  # GET /materials
  # GET /materials.json
  def index
    @materials = Material.all
    @suppliers = Supplier.all
    @raw_materials = RawMaterial.all
    super
  end

  # GET /materials/1
  # GET /materials/1.json
  def show
    @suppliers = Supplier.all
    @raw_materials = RawMaterial.all
    super
  end

  # GET /materials/new
  def new
    @material = Material.new
    @suppliers = Supplier.all
    @raw_materials = RawMaterial.all
    super
  end

  def new_internal
    @material = Material.new
    @suppliers = Supplier.all
    @raw_materials = RawMaterial.all
    if request.xhr?
      flash.discard(:notice)
      render partial: 'new_internal'
    else
      redirect_to "/dashboard##{request.path}"
    end
  end

  # GET /materials/1/edit
  def edit
    @suppliers = Supplier.all
    @raw_materials = RawMaterial.all
    super
  end

  # POST /materials
  # POST /materials.json
 def create
    if !validate_params(material_params) then
      redirect_to material_params['internal'] == "1" ? "/materials/new_internal" : "/materials/new", notice: 'تعذر تسجيل عملية الشراء. برجاء مراجعة المدخلات'
    else
      params = material_params
      if(!params['debt'])
        params['debt'] = 0
      end
      @material = Material.new(params)
      @material.in_stock = params[:quantity]
      @material.user_name = current_user.name

      if @material.debt > @material.price
        redirect_to material_params['internal'] == "1" ? "/materials/new_internal" : "/materials/new", notice: 'لا يمكن أن يكون المبلغ المتبقي أكبر من السعر'
        return
      end

      if !check_treasury(material_params[:payment_method], (params['price'].to_f - params['debt'].to_f))
        redirect_to material_params['internal'] == "1" ? "/materials/new_internal" : "/materials/new", notice: 'المبلغ الموجود بالخزنة أقل من المبلغ المطلوب'
        return
      end
      respond_to do |format|
        if @material.save
          update_treasury(@material.payment_method, -material_params['price'].to_f + material_params['debt'].to_f, MATERIAL, @material.id, "عملية شراء", 0)
          if @material.debt == 0
            add_tax(@material.payment_method, MATERIAL, @material.id, @material.price)
          end

          raw_material = RawMaterial.find(@material.raw_material_id)
          raw_material.in_stock = raw_material.in_stock + @material.quantity
          supplier = Supplier.find(@material.supplier_id)
          supplier.credit = supplier.credit + @material.debt
          permission1 = Permission.create!({transaction_type: 1, transaction_id: @material.id, quantity: @material.quantity})
          permission2 = Permission.create!({transaction_type: 5, transaction_id: @material.id, quantity: @material.price - @material.debt})

          supplier.save
          raw_material.save
          format.html { redirect_to "/permission/material/#{permission1.id}/#{permission2.id}" }
          format.json { render :show, status: :created, location: @material }
        else
          format.html { redirect_to "/materials/new", notice: 'تعذر تسجيل عملية الشراء. برجاء مراجعة المدخلات' }
          format.json { render json: @material.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /materials/1
  # PATCH/PUT /materials/1.json
  def update
    in_stock = @material.in_stock
    debt = @material.debt
    if !check_treasury(@material.payment_method, debt - material_params[:debt].to_f)
      redirect_to "/materials/#{@material.id}/edit", notice: 'المبلغ الموجود بالخزنة أقل من المبلغ المطلوب'
      return
    end
    respond_to do |format|
      if @material.update(material_params)
        money = debt - material_params[:debt].to_f
        if (debt != @material.debt)
          update_treasury(@material.payment_method, - money, MATERIAL, @material.id, "تعديل موقف عملية شراء", 0)
        end
        if debt > 0 && @material.debt == 0
          add_tax(@material.payment_method, MATERIAL, @material.id, @material.price)
        end
        if (in_stock > @material.in_stock)
          raw_material = RawMaterial.find(@material.raw_material_id)
          raw_material.in_stock = raw_material.in_stock - (in_stock - @material.in_stock)
        end
        
        
        supplier = Supplier.find(@material.supplier_id)
        supplier.credit = supplier.credit - money
        supplier.save
        if debt > @material.debt
          permission = Permission.create!({transaction_type: 5, transaction_id: @material.id, quantity: money})

          format.html { redirect_to "/permission/material_expense/#{permission.id}", notice: 'تم تعديل عملية الشراء بنجاح.' }
        else
          format.html { redirect_to @material }
        end
        format.json { render :show, status: :ok, location: @material }
      else
        format.html { render :edit }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materials/1
  # DELETE /materials/1.json
  def destroy
    @material.destroy
    respond_to do |format|
      format.html { redirect_to materials_url, notice: 'Material was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = Material.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def material_params
      pms = params.require(:material).permit(:raw_material_id, :quantity, :price, :supplier_id, :debt, :payment_method, :payment_state, :state, :in_stock, :currency, :due_date, :internal)
      pms[:internal] = params[:internal]
      return pms
    end

    def validate_params(params)
      if params[:raw_material_id].present? && params[:supplier_id].present? && params[:price].present? && params[:quantity].present? then
        return is_float?(params[:price]) && is_float?(params[:quantity])
      end
      return nil
    end
end
