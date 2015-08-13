class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]

  # GET /suppliers
  # GET /suppliers.json
  def index
    @suppliers = Supplier.all
    super
    flash.discard(:notice)
  end

  # GET /suppliers/1
  # GET /suppliers/1.json
  def show
    if params['_start'].present?
      @_start =   Date.strptime(params['_start'], "%m/%d/%Y")
    else
      @_start = 1.month.ago
    end
    if params['_end'].present?
      @_end = Date.strptime(params['_end'], "%m/%d/%Y")
    else
      @_end = DateTime.tomorrow
    end
    
    @materials = Material.where(["supplier_id = ?", @supplier.id]).where("date_added > ? and date_added <= ?", @_start, @_end)
    @raw_materials = RawMaterial.all
    super
  end

  # GET /suppliers/new
  def new
    @supplier = Supplier.new
    super
  end

  # GET /suppliers/1/edit
  def edit
    super
  end

  # POST /suppliers
  # POST /suppliers.json
  def create
    if !validate_params(supplier_params) then
      redirect_to "/suppliers/new", notice: 'تعذر إضافة الموزع. برجاء مراجعة المدخلات.'
    else
      @supplier = Supplier.new(supplier_params)

      respond_to do |format|
        if @supplier.save
          format.html { redirect_to suppliers_url, notice: 'Supplier was successfully created.' }
          format.json { render :show, status: :created, location: @supplier }
        else
          format.html { redirect_to "/suppliers/new", notice: 'تعذر إضافة الموزع. برجاء مراجعة المدخلات.' }
          format.json { render json: @supplier.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /suppliers/1
  # PATCH/PUT /suppliers/1.json
  def update
    credit = @supplier.credit
    if !check_treasury('cash', credit - supplier_params[:debt].to_f)
      redirect_to "/suppliers/#{@supplier.id}/edit", notice: 'المبلغ الموجود بالخزنة أقل من المبلغ المطلوب'
      return
    end
    respond_to do |format|
      if @supplier.update(supplier_params)
        if params["affects_treasury"] && @supplier.credit != credit
          update_treasury('cash', -credit + @supplier.credit, SUPPLIER, @supplier.id, "تعديل موقف مورد", 0)  
        end

        format.html { redirect_to suppliers_url, notice: 'تم تعديل بيانات الموزع.' }
        format.json { render :show, status: :ok, location: @supplier }
      else
        format.html { render :edit }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suppliers/1
  # DELETE /suppliers/1.json
  def destroy
    materials = Material.where("supplier_id = ?", @supplier.id)
    
    if purchases.empty?
      @supplier.destroy
    else
      @supplier.update(deleted: 1)
    end
    respond_to do |format|
      format.html { redirect_to suppliers_url, notice: 'Supplier was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supplier_params
      params[:supplier].permit(:name, :country, :zip, :address, :phone, :email, :contact_person, :credit, :bank)
    end

    def validate_params(params)
      if params[:name].present? && params[:country].present? && params[:email].present? && params[:contact_person].present? then
        if params[:credit].present? && !is_float?(params[:credit])
          return nil
        end
        if params[:zip].present? then
          return is_int?(params[:zip])
        end
      end
      return nil
    end
end
