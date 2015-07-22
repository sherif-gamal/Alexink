class ExpensePaymentDetailController < ApplicationController

	def edit
		@expense = ExpensePaymentDetail.find(params[:id])
		super
	end


  def update
  	@expense = ExpensePaymentDetail.find(params[:id])
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to '/diaries/index', notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

	private

	    # Never trust parameters from the scary internet, only allow the white list through.
	    def expense_params
	      params.require(:expense).permit!
	    end

end
