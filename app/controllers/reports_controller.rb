class ReportsController < ApplicationController
  def index
    @stat_types = StatType.controllable
  end

  def test
    @data = Report.test(params[:report])
    if @data.nil?
      flash[:alert] = 'No hay registros para generar el reporte'
      redirect_to reports_path
    end
  end
end