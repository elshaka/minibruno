class AlarmTypesController < ApplicationController
  before_action :set_alarm_type, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin

  def index
    @alarm_types = AlarmType.all
  end

  def new
    @alarm_type = AlarmType.new
  end

  def edit
  end

  def create
    @alarm_type = AlarmType.new(alarm_type_params)

    respond_to do |format|
      if @alarm_type.save
        format.html { redirect_to alarm_types_url, notice: 'Tipo de alarma creada con éxito.' }
        format.json { render :show, status: :created, location: @alarm_type }
      else
        format.html { render :new }
        format.json { render json: @alarm_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @alarm_type.update(alarm_type_params)
        format.html { redirect_to alarm_types_url, notice: 'Tipo de alarma actualizada creada con éxito.' }
        format.json { render :show, status: :ok, location: @alarm_type }
      else
        format.html { render :edit }
        format.json { render json: @alarm_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @alarm_type.destroy
        format.html { redirect_to alarm_types_url }
        format.json { head :no_content }
      else
        format.html { redirect_to alarm_types_url, alert: 'No se puede eliminar el tipo de alarma porque tiene registros asociados' }
        format.json { head :no_content, status: :bad_request }
      end
    end
  end

  private
    def set_alarm_type
      @alarm_type = AlarmType.find(params[:id])
    end

    def alarm_type_params
      params.require(:alarm_type).permit(:description, :code)
    end
end
