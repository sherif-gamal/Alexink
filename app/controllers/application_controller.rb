class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include SessionsHelper
  protect_from_forgery with: :exception

  before_filter :require_login

  # 1 = Material, 2 = Purchase, 3 = Supplier, 4 = Client, 5 = Manual
  MATERIAL = 1
  PURCHASE = 2
  SUPPLIER = 3
  CLIENT = 4
  MANUAL = 5
  EXPENSE = 6


  def index
    if request.xhr?
      flash.discard(:notice)
      render partial: 'index'
    else
      redirect_to "/dashboard##{request.path}"
    end
    #flash.discard(:notice)
  end

  def new
  	if request.xhr?
      flash.discard(:notice)
      render partial: 'new'
    else
      redirect_to "/dashboard##{request.path}"
    end
    #flash.discard(:notice)
  end

  def edit
  	if request.xhr?
      flash.discard(:notice)
      render partial: 'edit'
    else
      redirect_to "/dashboard##{request.path}"
    end
    #flash.discard(:notice)
  end

  def show
  	if request.xhr?
      flash.discard(:notice)
      render partial: 'show'
    else
      redirect_to "/dashboard##{request.path}"
    end
    #flash.discard(:notice)
  end

  def invoice
    if request.xhr?
      flash.discard(:notice)
      render partial: 'invoice'
    else
      redirect_to "/dashboard##{request.path}"
    end
    #flash.discard(:notice)
  end

  def success
    if request.xhr?
      flash.discard(:notice)
      render partial: 'success'
    else
      redirect_to "/dashboard##{request.path}"
    end
  end

  def is_int?(param)
    true if Integer(param) rescue false
  end

  def is_float?(param)
    true if Float(param) rescue false
  end

  def update_treasury(method, amount, transaction_type, transaction_id, description, is_tax, cheque_num = nil, date_added = nil)
    treasury = Treasury.first
    if method == "cash"
      treasury.cash = treasury.cash + amount
      p treasury
    elsif method == "bank"
      treasury.bank = treasury.bank + amount
    end
    treasury.save
    p date_added
    TreasuryDiary.create(transaction_id: transaction_id, transaction_type: transaction_type, amount: amount, description: description, is_tax: is_tax, p_method: method, cheque_num: cheque_num, date_added: date_added)
  end

  def add_tax(method, transaction_type, transaction_id, price)
    if transaction_type == MATERIAL
      amount = (price * 0.1 - price * 0.005).round(2)
      update_treasury(method, - amount, transaction_type, transaction_id, "ضريبة مشتريات", 1)
    elsif transaction_type == PURCHASE
      amount = (price * 0.1 - price * 0.005).round(2)
      update_treasury(method, amount, transaction_type, transaction_id, "ضريبة مشتريات", 1)
    end
  end

  def check_treasury(method, amount)
    treasury = Treasury.first
    if method == 'cash'
      return nil unless treasury.cash > amount
    elsif method == 'bank'
      return nil unless treasury.bank > amount
    end
    return true
  end

  private

    def require_login
      unless signed_in?
        redirect_to root_path
      end
    end
end
