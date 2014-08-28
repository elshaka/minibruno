class StatsController < ApplicationController
  def create
    @stat = Stat.new(stat_params.merge({user: current_user}))
    respond_to do |format|
      if @stat.save
        format.xml { render xml: @stat.id, status: :created }
      else
        format.xml { render xml: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def stat_params
    params.require(:stat).permit(:stat_type_id, :value, :set_point, :auto)
  end
end