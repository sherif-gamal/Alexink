class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.where.not(deleted: 1)
    super
    flash.discard(:notice)
  end

  # GET /products/1
  # GET /products/1.json
  def show
    super
  end

  # GET /products/new
  def new
    @product = Product.new
    super
  end

  # GET /products/1/edit
  def edit
    super
  end

  # POST /products
  # POST /products.json
  def create
    if !validate_params(product_params) then
      redirect_to "/products/new", notice: 'تعذر إضافة المنتج. برجاء مراجعة المدخلات.'
    else
      @product = Product.new(product_params)
      @product.in_stock = @product.quantity
      respond_to do |format|
        if @product.save
          permission = AddProductPermission.create!({transaction_id: @product.id, quantity: @product.quantity})

          format.html { redirect_to "/permission/product/#{permission.id}" }
          format.json { render :show, status: :created, location: @product }
        else
          redirect_to "/products/new", notice: 'تعذر إضافة المنتج. برجاء مراجعة المدخلات.'
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_url, notice: 'تم تعديل البيانات بنجاح.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    purchases = Purchase.where(["product_ids like ?", "%#{@product.id}%"])
    if purchases.empty?
      @product.destroy
    else
      @product.update(deleted: 1)
    end

    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :unit, :quantity, :in_stock, :description)
    end

    def validate_params(params)
      if params[:name].present? && params[:unit].present? && params[:quantity].present? then
          return is_float?(params[:quantity]) && (params[:in_stock].blank? || is_float?(params[:in_stock]))
      end
      return nil
    end
end
