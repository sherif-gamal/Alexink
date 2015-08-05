class RawMaterialsController < ApplicationController
  before_action :set_raw_material, only: [:show, :edit, :update, :destroy, :permit]

  # GET /raw_materials
  # GET /raw_materials.json
  def index
    @raw_materials = RawMaterial.where.not(deleted: 1)
    super
  end

  # GET /raw_materials/1
  # GET /raw_materials/1.json
  def show
    super
  end

  # GET /raw_materials/new
  def new
    @raw_material = RawMaterial.new
    super
  end

  # GET /raw_materials/1/edit
  def edit
    super
  end

  # POST /raw_materials
  # POST /raw_materials.json
  def create
    @raw_material = RawMaterial.new(raw_material_params)
    @raw_material.in_stock = 0

    respond_to do |format|
      if @raw_material.save
        format.html { redirect_to raw_materials_url, notice: 'تم تسجيل المادة الخام بنجاح.' }
        format.json { render :show, status: :created, location: @raw_material }
      else
        format.html { render :new }
        format.json { render json: @raw_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /raw_materials/1
  # PATCH/PUT /raw_materials/1.json
  def update
    respond_to do |format|
      if @raw_material.update(raw_material_params)
        format.html { redirect_to @raw_material, notice: 'تم تعديل المادة الخام بنجاح.' }
        format.json { render :show, status: :ok, location: @raw_material }
      else
        format.html { render :edit }
        format.json { render json: @raw_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /raw_materials/1
  # DELETE /raw_materials/1.json
  def destroy
    @raw_material.update(deleted: 1)
    
    respond_to do |format|
      format.html { redirect_to raw_materials_url, notice: 'تم حذف المادة الخام بنجاح.' }
      format.json { head :no_content }
    end
  end

  def production
    @raw_materials = RawMaterial.all
    if request.xhr?
      render partial: 'production'
    else
      redirect_to "/dashboard##{request.path}"
    end
  end

  def permit
    if (@raw_material.in_stock >= params['quantity'].to_f)
      @raw_material.in_stock = @raw_material.in_stock - params['quantity'].to_f
      @raw_material.save
      production = Production.create!({raw_material_id: @raw_material.id, user_name: current_user.name, quantity:params['quantity'].to_f})
      permission = ProductionPermission.create!({transaction_id: production.id, quantity: params['quantity']})
      redirect_to "/permission/production/#{permission.id}"
    else
      redirect_to '/raw_materials/production', notice: "المتاح بالمخزن أقل من الكمية المطلوبة"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raw_material
      @raw_material = RawMaterial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def raw_material_params
      params.require(:raw_material).permit(:name, :unit, :description, :in_stock, :deleted)
    end
end
