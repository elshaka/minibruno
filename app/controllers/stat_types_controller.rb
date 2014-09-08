class StatTypesController < ApplicationController
  before_action :set_stat_type, only: [:show, :edit, :update, :destroy]
  before_action :set_base_units, only: [:new, :edit]
  before_action :authorize_admin

  def index
    @stat_types = StatType.includes(:base_unit)
  end

  def show
  end

  def new
    @stat_type = StatType.new
  end

  def edit
  end

  def create
    @stat_type = StatType.new(stat_type_params)

    respond_to do |format|
      if @stat_type.save
        format.html { redirect_to stat_types_url, notice: 'Variable creada con éxito.' }
        format.json { render :show, status: :created, location: @stat_type }
      else
        format.html { render :new }
        format.json { render json: @stat_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @stat_type.update(stat_type_params)
        format.html { redirect_to stat_types_url, notice: 'Variable actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @stat_type }
      else
        format.html { render :edit }
        format.json { render json: @stat_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @stat_type.destroy
        format.html { redirect_to stat_types_url }
        format.json { head :no_content }
      else
        format.html { redirect_to stat_types_url, alert: 'No se puede eliminar la variable porque tiene registros asociados' }
        format.json { head :no_content, status: :bad_request }
      end
    end
  end

  private
    def set_stat_type
      @stat_type = StatType.find(params[:id])
    end

    def set_base_units
      @base_units = BaseUnit.all
    end

    def stat_type_params
      params.require(:stat_type).permit(:base_unit_id, :description, :controllable)
    end
end
