class DashboardController < ApplicationController
  def stats
    @stats = Stat.get_dashboard_stats
    respond_to do |format|
      format.json { render json: @stats, status: :ok }
    end
  end
end
