class PurchasePaymentDetailController < ApplicationController
	def edit
		@purchase = PurchasePaymentDetail.find(params[:id])
		super
	end

  def update
  	@purchase = PurchasePaymentDetail.find(params[:id])
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to '/diaries/index', notice: 'Purchase was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

	private

	    # Never trust parameters from the scary internet, only allow the white list through.
	    def purchase_params
	      params.require(:purchase_payment_detail).permit!
	    end
end
