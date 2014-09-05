class MotorsController < ApplicationController
  before_action :set_motor, only: [:show, :edit, :update, :destroy]

  def index
    @motors = Motor.all
  end

  def new
    @motor = Motor.new
  end

  def edit
  end

  def create
    @motor = Motor.new(motor_params)

    respond_to do |format|
      if @motor.save
        format.html { redirect_to motors_url, notice: 'Motor creado con éxito' }
        format.json { render :show, status: :created, location: @motor }
      else
        format.html { render :new }
        format.json { render json: @motor.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @motor.update(motor_params)
        format.html { redirect_to motors_url, notice: 'Motor actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @motor }
      else
        format.html { render :edit }
        format.json { render json: @motor.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @motor.destroy
    respond_to do |format|
      format.html { redirect_to motors_url, notice: 'Motor eliminado con éxito.' }
      format.json { head :no_content }
    end
  end

  private
    def set_motor
      @motor = Motor.find(params[:id])
    end

    def motor_params
      params.require(:motor).permit(:name, :description)
    end
end
