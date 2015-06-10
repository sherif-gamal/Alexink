class ProductionsController < ApplicationController
  before_action :set_production, only: [:show, :edit, :update, :destroy]

  # GET /productions
  # GET /productions.json
  def index
    @productions = Production.all
    @raw_materials = RawMaterial.all
    super
  end

  # GET /productions/1
  # GET /productions/1.json
  def show
    @raw_materials = RawMaterial.all
    super
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_production
      @production = Production.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def production_params
      params.require(:production).permit(:raw_material_id, :user_name, :quantity)
    end
end
