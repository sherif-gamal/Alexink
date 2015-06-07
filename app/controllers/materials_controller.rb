class MaterialsController < ApplicationController
  before_action :set_material, only: [:show, :edit, :update, :destroy, :success]

  # GET /materials
  # GET /materials.json
  def index
    @materials = Material.all
    @suppliers = Supplier.all
    super
    flash.discard(:notice)
  end
    

  # GET /materials/1
  # GET /materials/1.json
  def show
    @suppliers = Supplier.all
    super
  end

  # GET /materials/new
  def new
    @material = Material.new
    @suppliers = Supplier.all
    super
  end

  # GET /materials/1/edit
  def edit
    @suppliers = Supplier.all
    super
  end

  # POST /materials
  # POST /materials.json
 def create
    if !validate_params(material_params) then
      redirect_to "/materials/new", notice: 'تعذر تسجيل عملية الشراء. برجاء مراجعة المدخلات'
    else
      params = material_params
      if(!params[:debt])
        !params[:debt] = 0
      end
      @material = Material.new(params)
      @material.in_stock = params[:quantity]
      treasury = Treasury.first
      if (params['payment_method'] == "cash")
        if (treasury.cash < (params['price'].to_f - params['debt'].to_f))
          redirect_to "/materials/new", notice: 'المبلغ الموجود بالخزنة أقل من المبلغ المطلوب'
          return
        end
      elsif (treasury.bank < (params['price'].to_f - params['debt'].to_f))
        redirect_to "/materials/new", notice: 'المبلغ الموجود بالبنك أقل من المبلغ المطلوب'
        return
      end
      respond_to do |format|
        if @material.save
          if (material_params['payment_method'] == "cash")
            treasury.cash = treasury.cash - material_params['price'].to_f + material_params['debt'].to_f
          else
            treasury.bank = treasury.bank - material_params['price'].to_f + material_params['debt'].to_f
          end

          supplier = Supplier.find(@material.supplier_id)
          supplier.credit = supplier.credit + @material.debt

          supplier.save
          treasury.save
          format.html { redirect_to materials_url, notice: 'تم أضافة عملية الشراء بنجاح.' }
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
    respond_to do |format|
      if @material.update(material_params)
        treasury = Treasury.first
        if (params['payment_method'] == "cash")
          treasury.cash = treasury.cash - @material.debt + material_params[:debt].to_f
        else
          treasury.bank = treasury.bank - @material.debt + material_params[:debt].to_f
        end
        treasury.save
        supplier = Supplier.find(@material.supplier_id)
        supplier.debt = supplier.debt - @material.debt + material_params[:debt]
        supplier.save

        format.html { redirect_to @material, notice: 'Material was successfully updated.' }
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


  def confirm
    params = session[:params]
    material = Material.find(params['id'])
    material.in_stock = material.quantity - params['quantity'].to_f
    Permission.create({})
    respond_to do |format|
      if material.save
         format.html { redirect_to materials_url, notice: 'تم تسجيل عملية الصناعة.' }
      else
        format.html { redirect_to materials_url, notice: 'تم تسجيل عملية الصناعة.' }
      end
    end
  end

  def production
    @materials = Material.all
    if request.xhr?
      render partial: 'production'
    else
      redirect_to "/dashboard##{request.path}"
    end
  end

  def permit
    session[:params] = params
    if request.xhr?
      render partial: 'permission'
    else
      redirect_to "/dashboard#/materials/permission"
    end
  end

  def permission
    @params = session[:params]
    @material = Material.find(@params['id'])
    @permission_num = Permission.maximum(:id) || 0 + 1
    session[:permission_num] = @permission_num
    if (@material.in_stock >= @params['quantity'].to_f)
      render partial: 'permission'
    else
      redirect_to '/materials/production', notice: "المتاح بالمخزن أقل من الكمية المطلوبة"
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = Material.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def material_params
      params.require(:material).permit(:name, :unit, :quantity, :price, :supplier_id, :debt, :payment_method, :payment_state, :state)
    end

    def validate_params(params)
      if params[:name].present? && params[:supplier_id].present? && params[:price].present? && params[:unit].present? && params[:quantity].present? then
        return is_float?(params[:price]) && is_float?(params[:quantity])
      end
      return nil
    end
end
