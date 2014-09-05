class MotorStatsController < ApplicationController
  def create_multiple
    errors = []
    ids = []
    MotorStat.transaction do
      params[:motor_stats].each do |motor_stat_params|
        motor_stat_params = motor_stat_params.permit(:motor_id, :state, :created_at)
        motor_stat = MotorStat.new(motor_stat_params)
        unless motor_stat.save
          errors << motor_stat.errors
        else
          ids << motor_stat.id
        end
      end
    end
    respond_to do |format|
      if errors.empty?
        format.xml { render xml: ids, status: :created }
      else
        format.xml { render xml: errors, status: :unprocessable_entity }
      end
    end
  end
end
