class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.where.not(deleted: 1)
    super
  end

  # GET /users/1
  # GET /users/1.json
  def show
    super
  end

  # GET /users/new
  def new
    @user = User.new
    super
  end

  # GET /users/1/edit
  def edit
    super
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'تم تسجيل الموظف بنجاح.' }
        format.json { render partial: 'show', status: :created, location: @user }
      else
        format.html { redirect_to '/dashboard#users/new', notice: 'تعذر تسجيل الموظف. برجاء مراجعة البيانات المدخلة.'}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    puts "zzzzzzzzzzzzzzzzz #{user_params[:password]}"
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'تم تعديل البيانات بنجاح.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to edit_user_path, notice: "تعذر تعديل البيانات" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.id == 1
      redirect_to users_url, notice: "لا يمكن مسح المدير"
      return
    end
    @user.update(deleted: 1)
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def login
    @user = User.new
  end

  def authenticate
    user = params[:user]
    if User.authenticate user[:email], user[:password]
      redirect_to '/dashboard'
    else
      redirect_to '/users/login'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :occupation, :department, :address, :password_confirmation, :phone, :deleted)
    end
end
