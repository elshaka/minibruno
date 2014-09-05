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

  def metering_bin
    @data = Report.metering_bin(params[:report])
    if @data.nil?
      flash[:alert] = 'No hay registros para generar el reporte'
      redirect_to reports_path
    end
  end

  def discharges_and_temperatures
    @data = Report.discharges_and_temperatures(params[:report])
    if @data.nil?
      flash[:alert] = 'No hay registros para generar el reporte'
      redirect_to reports_path
    end
  end

  def pumped_fat
    @data = Report.pumped_fat(params[:report])
    if @data.nil?
      flash[:alert] = 'No hay registros para generar el reporte'
      redirect_to reports_path
    end
  end
end
