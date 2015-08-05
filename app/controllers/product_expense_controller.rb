class ProductExpenseController < ApplicationController

  def edit
  	@product = ProductExpense.find(params[:id])
    if request.xhr?
      flash.discard(:notice)
      render partial: 'product_expense'
    else
      redirect_to "/dashboard##{request.path}"
    end
  end

  def update

  end

end
