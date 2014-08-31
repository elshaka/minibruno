class AlarmsController < ApplicationController
  def create
    @alarm = Alarm.new(alarm_params.merge({user: current_user}))
    respond_to do |format|
      if @alarm.save
        format.xml { render xml: @alarm.id, status: :created }
      else
        format.xml { render xml: @alarm.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def alarm_params
    params.require(:alarm).permit(:alarm_type_id)
  end
end
