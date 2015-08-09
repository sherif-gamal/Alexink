class MaterialPaymentDetailController < ApplicationController

	def edit
		@material = MaterialPaymentDetail.find(params[:id])
		super
	end


  def update
  	@material = MaterialPaymentDetail.find(params[:id])
    respond_to do |format|
      if @material.update(material_params)
        format.html { redirect_to '/diaries/index', notice: 'Material was successfully updated.' }
        format.json { render :show, status: :ok, location: @material }
      else
        format.html { render :edit }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

	private

	    # Never trust parameters from the scary internet, only allow the white list through.
	    def material_params
	      params.require(:material_payment_detail).permit!
	    end

end
