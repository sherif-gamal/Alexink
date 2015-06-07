class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]

  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = Purchase.all
    @clients = Client.all
    @products = Product.all
    super
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
    @clients = Client.all
    @products = Product.all
    super
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
    @clients = Client.all
    @products = Product.all
    super
  end

  # GET /purchases/1/edit
  def edit
    @clients = Client.all
    @products = Product.all
    super
  end

  # POST /purchases
  # POST /purchases.json

  def create
    if validate_params(purchase_params) then
      session[:params] = purchase_params
      redirect_to '/purchases/invoice'
    else
      redirect_to "/purchases/new", notice: 'تعذر تسجيل عملية البيع. برجاء مراجعة المدخلات'
    end
  end

  def invoice
    @params = session[:params]
    @client = Client.find(@params['client_id'])
    @product = Product.find(@params['product_id'])
    @invoice_num = Invoice.maximum(:id) || 0 + 1
    session[:invoice_num] = @invoice_num

    if (@product.in_stock < @params['quantity'].to_f)
      redirect_to '/purchases/new', notice: 'الكمية المتاحة بالمخزن من ذلك المنتج أقل من المطلوب'
    else
      super
    end
  end

  def confirm
    @purchase = Purchase.new(session[:params])
    @purchase.invoice_id = session[:invoice_num]
    respond_to do |format|
      if @purchase.save
         invoice = Invoice.create({purchase_id: @purchase.id})
         treasury = Treasury.first
         p "aaaaaaaaaaaaaaaaaa"
         p treasury
         if (@purchase.payment_method == "cash")
          p 'zzzzzzzzzzzzzz'
          treasury.cash = treasury.cash + @purchase.price - @purchase.debt
          p treasury
         else
          p 'yyyyyyyyyyyyyy'
          treasury.bank = treasury.bank + @purchase.price - @purchase.debt
          p treasury
         end
         client = Client.find(@purchase.client_id)
         client.debt = client.debt + @purchase.debt
         product = Product.find(@purchase.product_id)
         product.in_stock = product.in_stock - @purchase.quantity

         treasury.save
         client.save
         product.save

         format.html { redirect_to purchases_url, notice: 'تم تسجيل عملية البيع.' }
         format.json { render :show, status: :created, location: @purchase }
      else
        format.html { render :new }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
    session[:param] = nil
    session[:invoice_num] = nil
  end

  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        treasury = Treasury.first
        if (params['payment_method'] == "cash")
          treasury.cash = treasury.cash + (@purchase.debt - purchase_params[:debt].to_f)
        else
          treasury.bank = treasury.bank + (@purchase.debt - purchase_params[:debt].to_f)
        end
        treasury.save
        client = Client.find(@purchase.client_id)
        client.debt = client.debt - (@purchase.debt - purchase_params[:debt].to_f)
        client.save

        format.html { redirect_to purchases_url, notice: 'Purchase was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_url, notice: 'Purchase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit(:product_id, :payment_method, :payment_state, :quantity, :price, :client_id, :payment_method, :payment_state, :state, :debt)
    end

    def validate_params(params)
      if params[:product_id].present? && params[:client_id].present? && params[:price].present? && params[:quantity].present? then
        return is_float?(params[:price]) && is_float?(params[:quantity])
      end
      return nil
    end
end
