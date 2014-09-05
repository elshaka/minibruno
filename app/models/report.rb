class Report
  def self.temperatures(params)
    return nil if params[:date].blank?
    temperature_types = StatType.where(base_unit_id: 1)
    return nil if temperature_types.empty?
    time_range = generate_time_range(params)
    return nil if time_range.nil?

    temperatures = []
    temperature_types.each do |temperature_type|
      stats = Stat.where(stat_type_id: temperature_type.id)
      stats = stats.where(created_at: time_range)
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
    time_range = generate_time_range(params)
    return nil if time_range.nil?
    stat_type = StatType.find(params[:stat_type_id])
    stats = Stat.where(stat_type_id: params[:stat_type_id])
    stats = stats.where(created_at: time_range)
    return nil if stats.empty?

    stats = stats.pluck(:value, :set_point, :auto, :created_at)
      .reduce(Hash.new { |hash, key| hash[key] = [] }) do |stats, stat|
        stats[:values] << stat[0]
        stats[:set_points] << stat[1]
        stats[:autos] << stat[2]
        stats[:timestamps] << stat[3].to_time.to_i * 1000
        stats
    end

    data = {}
    data[:title] = stat_type.description
    data[:controllable] = stat_type.controllable
    data[:date] = params[:date]
    data[:stats] = stats
    data
  end

  def self.metering_bin(params)
    return nil if params[:start_time].blank? or params[:end_time].blank?
    time_range = generate_time_range(params)
    return nil if time_range.nil?
    levels = Stat.where(stat_type_id: 9).where(created_at: time_range)
    discharges = Stat.where(stat_type_id: 8).where(created_at: time_range)
    return nil if levels.nil? and metering_bin_levels.empty?

    levels = levels.pluck(:value, :created_at)
      .reduce(Hash.new { |hash, key| hash[key] = [] }) do |levels, level|
        levels[:values] << level[0]
        levels[:timestamps] << level[1].to_time.to_i * 1000
        levels
    end
    discharges = discharges.pluck(:value, :created_at)
      .reduce(Hash.new { |hash, key| hash[key] = [] }) do |discharges, discharge|
        discharges[:values] << discharge[0]
        discharges[:timestamps] << discharge[1].to_time.to_i * 1000
        discharges
    end

    data = {}
    data[:title] = 'Descargas Metering Bin'
    data[:start_time] = time_range.begin
    data[:end_time] =  time_range.end
    data[:levels] = levels
    data[:discharges] = discharges
    data
  end

  def self.discharges_and_temperatures(params)
    return nil if params[:start_time].blank? or params[:end_time].blank?
    time_range = generate_time_range(params)
    return nil if time_range.nil?
    discharges = Stat.where(stat_type_id: 8).where(created_at: time_range)
    final_temps = Stat.where(stat_type_id: 6).where(created_at: time_range)
    vapor_temps = Stat.where(stat_type_id: 7).where(created_at: time_range)
    return nil if time_range.nil? and metering_bin_levels.empty?

    turn_discharges = Turn.all.map do |turn|
      {
        name: turn.name,
        total: discharges.where(['TIME(created_at) BETWEEN TIME(?) AND TIME(?)', turn.start_time, turn.end_time]).sum(:value)
      }
    end

    discharges = discharges.pluck(:value, :created_at)
      .reduce(Hash.new { |hash, key| hash[key] = [] }) do |discharges, discharge|
        discharges[:values] << discharge[0]
        discharges[:timestamps] << discharge[1].to_time.to_i * 1000
        discharges
    end

    final_temps = final_temps.pluck(:value, :created_at)
      .reduce(Hash.new { |hash, key| hash[key] = [] }) do |final_temps, final_temp|
        final_temps[:values] << final_temp[0]
        final_temps[:timestamps] << final_temp[1].to_time.to_i * 1000
        final_temps
    end

    vapor_temps = vapor_temps.pluck(:value, :created_at)
      .reduce(Hash.new { |hash, key| hash[key] = [] }) do |vapor_temps, vapor_temp|
        vapor_temps[:values] << vapor_temp[0]
        vapor_temps[:timestamps] << vapor_temp[1].to_time.to_i * 1000
        vapor_temps
    end

    data = {}
    data[:title] = 'Descargas, temperatura final y temperatura vapor'
    data[:start_time] = time_range.begin
    data[:end_time] =  time_range.end
    data[:discharges] = discharges
    data[:final_temps] = final_temps
    data[:vapor_temps] = vapor_temps
    data
  end

  def alarms(params)
  end

  private

  def self.generate_time_range(params)
    begin
      if params[:with_time_range] == '0'
        datetime = Time.parse(params[:date])
        datetime + 7.hours .. datetime + 1.day + 7.hours
      else
        Time.parse(params[:start_time]) .. Time.parse(params[:end_time])
      end
    rescue
      nil
    end
  end
end
