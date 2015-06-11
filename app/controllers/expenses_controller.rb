class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = Expense.all
    super
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
      session[:params] = expense_params
      redirect_to '/dashboard#/expenses/permission'
    else
      redirect_to "/expenses/new", notice: 'تعذر تسجيل عملية الصرف. برجاء مراجعة المدخلات'
    end
  end

  def permission
    @params = session[:params]
    @permission_num = Permission.maximum(:id) || 0 + 1
    session[:permission_num] = @permission_num
    treasury = Treasury.first
    if (@params['payment_method'] == "cash")
      if (treasury.cash < (@params['price'].to_f - @params['debt'].to_f))
        redirect_to "/expenses/new", notice: 'المبلغ الموجود بالخزنة أقل من المبلغ المطلوب'
        return
      end
    elsif (treasury.bank < (@params['price'].to_f - @params['debt'].to_f))
      redirect_to "/expenses/new", notice: 'المبلغ الموجود بالبنك أقل من المبلغ المطلوب'
      return
    end
    render partial: 'permission'
  end

  def confirm
    params = session[:params]
    @expense = Expense.new(params)
    @expense.user_name = current_user.name

    respond_to do |format|
      if @expense.save
        Permission.create({})
        treasury = Treasury.first
        if (params['payment_method'] == "cash")
          treasury.cash = treasury.cash - @expense.price + @expense.debt
        else
          treasury.bank = treasury.bank - @expense.price + @expense.debt
        end
        treasury.save
        format.html { redirect_to expenses_url, notice: 'تم تسجيل عملية الصرف.' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { redirect_to "/expenses/new", notice: 'تعذر تسجيل المصروف. برجاء مراجعة المدخلات' }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
    session[:params] = nil
    session[:permission_num] = nil
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        treasury = Treasury.first
        if (params['payment_method'] == "cash")
          treasury.cash = treasury.cash - @expense.debt + expense_params[:debt]
        else
          treasury.bank = treasury.bank - @expense.debt + expense_params[:debt]
        end
        treasury.save

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
        return is_float?(params[:price]) && is_float?(params[:debt])
      end
      return nil
    end
end
