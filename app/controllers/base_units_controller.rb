class BaseUnitsController < ApplicationController
  before_action :set_base_unit, only: [:edit, :update, :destroy]
  before_action :authorize_admin

  def index
    @base_units = BaseUnit.all
  end

  def new
    @base_unit = BaseUnit.new
  end

  def edit
  end

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

  def destroy
    respond_to do |format|
      if @base_unit.destroy
        format.html { redirect_to base_units_url }
        format.json { head :no_content }
      else
        format.html { redirect_to base_units_url, alert: 'No se puede eliminar la unidad base porque tiene registros asociados' }
        format.json { head :no_content, status: :bad_request }
      end
    end
  end

  private
    def set_base_unit
      @base_unit = BaseUnit.find(params[:id])
    end

    def base_unit_params
      params.require(:base_unit).permit([:unit, :description])
    end
end
