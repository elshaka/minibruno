class StopsController < ApplicationController
  def start
    @stop = Stop.new(stop_params.merge({user: current_user}))
    respond_to do |format|
      if @stop.save
        format.xml { render xml: @stop.id, status: :created }
      else
        format.xml { render xml: @stop.errors, status: :unprocessable_entity }
      end
    end
  end

  def end
    @stop = Stop.where(ended_at: nil).last
    respond_to do |format|
      unless @stop.nil?
      	@stop.end
        format.xml { render xml: @stop.id, status: :ok }
      else
        format.xml { render xml: @stop.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def stop_params
    params.require(:stop).permit(:description)
  end
end