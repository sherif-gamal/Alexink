class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all
    super
    flash.discard(:notice)
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @purchases = Purchase.where(["client_id = ?", @client.id])
    @products = Product.all
    super
  end

  # GET /clients/new
  def new
    @client = Client.new
    super
  end

  # GET /clients/1/edit
  def edit
    super
  end

  # POST /clients
  # POST /clients.json
  def create
    if !validate_params(client_params) then
      redirect_to "/clients/new", notice: 'تعذر إضافة العميل. برجاء مراجعة المدخلات.'
    else
      @client = Client.new(client_params)
      if (client_params['debt'].blank?)
        @client.debt = 0
      end
      respond_to do |format|
        if @client.save
          format.html { redirect_to clients_url, notice: 'تم إضافة العميل بنجاح.' }
          format.json { render :show, status: :created, location: @client }
        else
          format.html { redirect_to "/clients/new", notice: 'تعذر إضافة العميل. برجاء مراجعة المدخلات.' }
          format.json { render json: @client.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    if !validate_params(client_params) then
      redirect_to "/clients/edit", notice: 'تعذر تعديل البيانات. برجاء مراجعة المدخلات'
    else
      debt = @client.debt
      respond_to do |format|
        if @client.update(client_params)
          if params["affects_treasury"] && @client.debt != debt
            update_treasury(params['payment_method'], (debt - @client.debt), CLIENT, @client.id, "تعديل موقف العميل", 0)
          end


          format.html { redirect_to clients_url, notice: 'تم تعديل بيانات العميل.' }
          format.json { render :show, status: :ok, location: @client }
        else
          format.html { render :edit }
          format.json { render json: @client.errors, status: :unprocessable_entity }
        end
      end
    end 
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name, :country, :zip, :address, :phone, :email, :contact_person, :debt)
    end

    def validate_params(params)
      p params
      if params[:name].present? && params[:country].present? && params[:address].present? then
        if params[:zip].present? then
          return is_int?(params[:zip]) && (params[:debt].blank? || is_float?(params[:debt]))
        end
      end
      return nil
    end
end
