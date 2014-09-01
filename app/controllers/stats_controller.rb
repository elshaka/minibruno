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

  def create_multiple
    errors = []
    ids = []
    user_id = current_user.id
    Stat.transaction do
      params[:stats].each do |stat_params|
        stat_params = stat_params.permit(:stat_type_id, :value, :set_point, :auto)
        stat = Stat.new(stat_params.merge({user_id: user_id}))
        unless stat.save
          errors << stat.errors
        else
          ids << stat.id
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

  private

  def stat_params
    params.require(:stat).permit(:stat_type_id, :value, :set_point, :auto)
  end
end