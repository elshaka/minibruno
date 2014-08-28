class BaseUnitsController < ApplicationController
  before_action :set_base_unit, only: [:show, :edit, :update, :destroy]

  # GET /base_units
  # GET /base_units.json
  def index
    @base_units = BaseUnit.all
  end

  # GET /base_units/1
  # GET /base_units/1.json
  def show
  end

  # GET /base_units/new
  def new
    @base_unit = BaseUnit.new
  end

  # GET /base_units/1/edit
  def edit
  end

  # POST /base_units
  # POST /base_units.json
  def create
    @base_unit = BaseUnit.new(base_unit_params)

    respond_to do |format|
      if @base_unit.save
        format.html { redirect_to base_units_url, notice: 'Unidad base creada con éxito.' }
        format.json { render :show, status: :created, location: @base_unit }
      else
        format.html { render :new }
        format.json { render json: @base_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /base_units/1
  # PATCH/PUT /base_units/1.json
  def update
    respond_to do |format|
      if @base_unit.update(base_unit_params)
        format.html { redirect_to base_units_url, notice: 'Unidad base actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @base_unit }
      else
        format.html { render :edit }
        format.json { render json: @base_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /base_units/1
  # DELETE /base_units/1.json
  def destroy
    @base_unit.destroy
    respond_to do |format|
      format.html { redirect_to base_units_url, notice: 'Unidad base eliminada con éxito.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_base_unit
      @base_unit = BaseUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def base_unit_params
      params.require(:base_unit).permit([:unit, :description])
    end
end
