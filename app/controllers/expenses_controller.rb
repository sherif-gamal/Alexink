class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  GENERAL = 0
  PRODUCTION = 1

  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = Expense.all
    super
    flash.discard(:notice)
  end

  def index_general
    @expenses = Expense.where(type: GENERAL)
    if request.xhr?
      flash.discard(:notice)
      render partial: 'index'
    else
      redirect_to "/dashboard##{request.path}"
    end
    flash.discard(:notice)
  end

  def index_production
    @expenses = Expense.where(type: PRODUCTION)
    if request.xhr?
      flash.discard(:notice)
      render partial: 'index'
    else
      redirect_to "/dashboard##{request.path}"
    end
    flash.discard(:notice)
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
    super
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
    super
  end

  # GET /expenses/1/edit
  def edit
    super
  end

  # POST /expenses
  # POST /expenses.json

  def create
    if validate_params(expense_params) then
      treasury = Treasury.first
      if (expense_params['payment_method'] == "cash")
        if (treasury.cash < (expense_params['price'].to_f))
          redirect_to "/expenses/new", notice: 'المبلغ الموجود بالخزنة أقل من المبلغ المطلوب'
          return
        end
      elsif (treasury.bank < (expense_params['price'].to_f))
        redirect_to "/expenses/new", notice: 'المبلغ الموجود بالبنك أقل من المبلغ المطلوب'
        return
      end
      @expense = Expense.new(expense_params)
      @expense.user_name = current_user.name

      if @expense.save
        permission = ReleaseMoneyPermission.create!({transaction_for: EXPENSE, transaction_id: @expense.id, quantity: @expense.price})
        ExpensePaymentDetail.create()
        update_treasury(@expense.payment_method, - @expense.price, EXPENSE, @expense.id, "مصروفات مباشرة", 0)
        redirect_to "/permission/expense/#{permission.id}"
      else
        redirect_to "/expenses/new", notice: 'تعذر تسجيل عملية الصرف. برجاء مراجعة المدخلات'  
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expenses_url, notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:name, :price, :seller, :payment_method, :payment_state, :debt)
    end

    def validate_params(params)
      if params[:name].present? && params[:seller].present? && params[:price].present? then
        return is_float?(params[:price])
      end
      return nil
    end
end
