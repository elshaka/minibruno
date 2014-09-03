class ReportsController < ApplicationController
  def index
    @stat_types = StatType.order(:base_unit_id)
  end

  def temperatures
    @data = Report.temperatures(params[:report])
    if @data.nil?
      flash[:alert] = 'No hay registros para generar el reporte'
      redirect_to reports_path
    end
  end

  def variable
    @data = Report.variable(params[:report])
    if @data.nil?
      flash[:alert] = 'No hay registros para generar el reporte'
      redirect_to reports_path
    end
  end
end
