class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include SessionsHelper
  protect_from_forgery with: :exception

  before_filter :require_login

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

  private

    def require_login
      unless signed_in?
        redirect_to root_path
      end
    end
end
