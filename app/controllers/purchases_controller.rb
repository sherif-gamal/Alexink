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
    @clients = Client.where.not(deleted: 1)
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
    _params = purchase_params
    if validate_params(_params) then
      purchase = Purchase.new(_params)
      purchase.user_name = current_user.name
      products = Product.find(_params['product_ids'])
      products.each_with_index do |product, i|
        if (product.in_stock < _params['quantities'][i].to_f)
          redirect_to '/purchases/new', notice: 'الكمية المتاحة بالمخزن من ذلك المنتج أقل من المطلوب'
          return
        end
      end
      purchase.price = 0
      purchase.prices.each_with_index do |price, i|
        purchase.price = purchase.price + price.to_f * purchase.quantities[i].to_f
      end
      if _params['debt'].present? && purchase.price < _params['paid_amount'].to_f
        redirect_to '/purchases/new', notice: 'لا يمكن أن يكون المبلغ المدفوع أكبر من السعر الكلي'
        return
      end
      purchase.debt = purchase.price_with_taxes - params["paid_amount"].to_f
      if purchase.save
         invoice = Invoice.create!({purchase_id: purchase.id})
         permission = ReleaseProductPermission.create!({transaction_id: purchase.id})
         purchase.invoice_id = invoice.id
         purchase.save
         update_treasury(purchase.payment_method, params["paid_amount"].to_f, PURCHASE, purchase.id, "عملية بيع", 0, params["cheque_num"], purchase.date_added)
         # if purchase.debt == 0
         #  add_tax(purchase.payment_method, PURCHASE, purchase.id, purchase.price)
         # end
         # treasury = Treasury.first
         # if (purchase.payment_method == "cash")
         #  treasury.cash = treasury.cash + purchase.price - purchase.debt
         # else
         #  treasury.bank = treasury.bank + purchase.price - purchase.debt
         # end
         client = Client.find(purchase.client_id)
         client.debt = client.debt + purchase.debt
         products.each_with_index do |product, i|
          product.in_stock = product.in_stock - purchase.quantities[i].to_f
          product.save
         end

         # treasury.save
         client.save
         PurchasePaymentDetail.create()

         redirect_to "/permission/purchase/#{permission.id}/#{invoice.id}"
      end
    else
      redirect_to '/purchases/new', notice: 'حدث خطأ في معالجة الطلب. برجاء مراجعة المدخلات'
    end
  end

  def invoice
    @invoice = Invoice.find(params[:id])
    @purchase = Purchase.find(@invoice.purchase_id)
    @client = Client.find(@purchase.client_id)
    @products = Product.find(@purchase.product_ids)
    super
  end

  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  def update
    debt = @purchase.debt
    respond_to do |format|
      if @purchase.update(purchase_params)
        if (debt != @purchase.debt)
          update_treasury(@purchase.payment_method, debt - @purchase.debt, PURCHASE, @purchase.id, "تعديل موقف عملية بيع", 0, params["cheque_num"])
        end
        # if debt > 0 && @purchase.debt == 0
        #   add_tax(@purchase.payment_method, PURCHASE, @purchase.id, @purchase.price)
        # end
        # treasury = Treasury.first
        # if (params['payment_method'] == "cash")
        #   treasury.cash = treasury.cash + (@purchase.debt - purchase_params[:debt].to_f)
        # else
        #   treasury.bank = treasury.bank + (@purchase.debt - purchase_params[:debt].to_f)
        # end
        # treasury.save
        client = Client.find(@purchase.client_id)
        client.debt = client.debt - (debt - purchase_params[:debt].to_f)
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
    permissions = ReleaseProductPermission.where(transaction_id: @purchase.id)
    PurchasePaymentDetail.find(@purchase.id).destroy
    update_treasury(@purchase.payment_method, -@purchase.price_with_taxes, PURCHASE, @material.id, "مسح حركة بيع", 0)
    TreasuryDiary.where(transaction_id: @purchase.id, transaction_type: PURCHASE).destroy_all
    permissions.destroy_all
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
      _params = params.require(:purchase).permit(:date_added, :payment_method, :calc_sub_tax,
       :payment_state, :client_id, :payment_method, :payment_state, :state, :debt,
        :quantities => [], :prices => [], )
      _params[:product_ids] = params[:product_ids]
      p _params
    end

    def validate_params(params)  
      params[:prices].each do |price|
        if !is_float?(price)
          return nil
        elsif price.to_f < 0
          return nil
        end
      end
      params[:quantities].each do |quantity|
        if !is_float?(quantity)
          return nil
        elsif quantity.to_f < 0
          return nil
        end
      end
      return true
    end
end
