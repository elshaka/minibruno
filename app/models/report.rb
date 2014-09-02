class Report
  def self.variable(params)
    return nil if params[:date].blank?
    return nil if Stat.where(stat_type_id: params[:stat_type_id]).empty?
    stat_type = StatType.find(params[:stat_type_id])
    data = {}
    data[:title] = stat_type.description
    data[:controllable] = stat_type.controllable
    data[:date] = params[:date]
    data[:stats] = Stat
      .where(stat_type_id: params[:stat_type_id])
      .where(created_at: Time.parse(params[:date]) +  7.hours .. Date.parse(params[:date]) + 1.day + 7.hours)
      .pluck(:value, :set_point, :auto, :created_at)
      .reduce(Hash.new { |hash, key| hash[key] = [] }) do |stats, stat|
        stats[:values] << stat[0]
        stats[:set_points] << stat[1]
        stats[:autos] << stat[2]
        stats[:timestamps] << stat[3].to_time.to_i * 1000
        stats
    end
    data
  end
end
