class Report
  def self.temperatures(params)
    return nil if params[:date].blank?
    temperature_types = StatType.where(base_unit_id: 1)
    return nil if temperature_types.empty?
    date = Time.parse(params[:date])
    temperatures = []
    temperature_types.each do |temperature_type|
      stats = Stat.where(stat_type_id: temperature_type.id)
      stats = stats.where(created_at: date +  7.hours .. date + 1.day + 7.hours)
      stats = stats.pluck(:value, :created_at)
        .reduce(Hash.new { |hash, key| hash[key] = [] }) do |stats, stat|
          stats[:values] << stat[0]
          stats[:timestamps] << stat[1].to_time.to_i * 1000
          stats
      end
      if stats.any?
        temperatures << {
          description: temperature_type.description,
          stats: stats
        }
      end
    end
    return nil if temperatures.empty?
    data = {}
    data[:title] = "Temperaturas"
    data[:date] = params[:date]
    data[:temperatures] = temperatures
    data
  end

  def self.variable(params)
    return nil if params[:date].blank?
    date = Time.parse(params[:date])
    stats = Stat
      .where(stat_type_id: params[:stat_type_id])
      .where(created_at: date +  7.hours .. date + 1.day + 7.hours)
    return nil if stats.empty?
    stat_type = StatType.find(params[:stat_type_id])
    data = {}
    data[:title] = stat_type.description
    data[:controllable] = stat_type.controllable
    data[:date] = params[:date]
    data[:stats] = stats.pluck(:value, :set_point, :auto, :created_at)
      .reduce(Hash.new { |hash, key| hash[key] = [] }) do |stats, stat|
        stats[:values] << stat[0]
        stats[:set_points] << stat[1]
        stats[:autos] << stat[2]
        stats[:timestamps] << stat[3].to_time.to_i * 1000
        stats
    end
    data
  end

  def alarms
  end
end
