class TurnsController < ApplicationController
  before_action :set_turn, only: [:show, :edit, :update, :destroy]
  before_action :authorize_supervisor

  def index
    @turns = Turn.all
  end

  def new
    @turn = Turn.new
  end

  def edit
  end

  def create
    @turn = Turn.new(turn_params)

    respond_to do |format|
      if @turn.save
        format.html { redirect_to turns_url, notice: 'Turno creado con éxito' }
        format.json { render :show, status: :created, location: @turn }
      else
        format.html { render :new }
        format.json { render json: @turn.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @turn.update(turn_params)
        format.html { redirect_to turns_url, notice: 'Turno actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @turn }
      else
        format.html { render :edit }
        format.json { render json: @turn.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @turn.destroy
    respond_to do |format|
      format.html { redirect_to turns_url, notice: 'Turno eliminado con éxito.' }
      format.json { head :no_content }
    end
  end

  private
    def set_turn
      @turn = Turn.find(params[:id])
    end

    def turn_params
      params.require(:turn).permit(:name, :start_time, :end_time)
    end
end
