class Report
  def self.test(params)
    return nil if Stat.where(stat_type_id: params[:stat_type_id]).empty?
    data = {}
    data[:stats] = Stat
      .where(stat_type_id: params[:stat_type_id])
      .pluck(:value, :set_point, :auto, :created_at)
      .reduce(Hash.new { |hash, key| hash[key] = [] }) do |stats, stat|
        stats[:values] << stat[0]
        stats[:set_points] << stat[1]
        stats[:autos] << stat[2]
        stats[:timestamps] << stat[3].to_time.to_i * 1000
        stats
    end
    data[:title] = StatType.find(params[:stat_type_id]).description
    data
  end
end
