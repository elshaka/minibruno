class Report
  def self.temperatures(params)
    time_range, data = init(params, 'Temperaturas')
    return nil if time_range.nil?
    temperature_types = StatType.where(base_unit_id: 1)
    return nil if temperature_types.empty?

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

    data[:temperatures] = temperatures
    data
  end

  def self.variable(params)
    stat_type = StatType.find(params[:stat_type_id])
    time_range, data = init(params, stat_type.description)
    return nil if time_range.nil?
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

    data[:unit] = stat_type.base_unit
    data[:controllable] = stat_type.controllable
    data[:start_time] = time_range.begin
    data[:end_time] = time_range.end
    data[:stats] = stats
    data
  end

  def self.metering_bin(params)
    time_range, data = init(params, 'Nivel del metering bin')
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

    data[:levels] = levels
    data[:discharges] = discharges
    data
  end

  def self.discharges_and_temperatures(params)
    time_range, data = init(params, 'Descargas, temperatura final y temperatura vapor')
    return nil if time_range.nil?
    discharges = Stat.where(stat_type_id: 8).where(created_at: time_range)
    final_temps = Stat.where(stat_type_id: 6).where(created_at: time_range)
    vapor_temps = Stat.where(stat_type_id: 7).where(created_at: time_range)
    return nil if discharges.empty? and final_temps.empty? and vapor_temps.empty?

    total_discharges = 0
    turn_discharges = Turn.all.map do |turn|
      turn_discharges = discharges.where([turn_time_condition(turn), turn.start_time, turn.end_time]).sum(:value)
      total_discharges += turn_discharges
      {
        name: turn.name,
        total: turn_discharges
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

    data[:discharges] = discharges
    data[:final_temps] = final_temps
    data[:vapor_temps] = vapor_temps
    data[:turn_discharges] = turn_discharges
    data[:total_discharges] = total_discharges
    data
  end

  def self.pumped_fat(params)
    time_range, data = init(params, 'Bombeo de grasa, acumulado y total bombeado por turno')
    return nil if time_range.nil?
    pumped_fat = Stat.where(stat_type_id: 10).where(created_at: time_range)
    return nil if pumped_fat.empty?

    total_pumped_fat = 0
    turn_pumped_fat = Turn.all.map do |turn|
      turn_pumped_fat = pumped_fat.where([turn_time_condition(turn), turn.start_time, turn.end_time]).sum(:value)
      total_pumped_fat += turn_pumped_fat
      {
        name: turn.name,
        total: turn_pumped_fat
      }
    end

    pumped_fat = pumped_fat.pluck(:value, :created_at)
      .reduce(Hash.new { |hash, key| hash[key] = [] }) do |pumped_fat, pf|
        pumped_fat[:values] << pf[0]
        pumped_fat[:timestamps] << pf[1].to_time.to_i * 1000
        pumped_fat
    end

    data[:pumped_fat] = pumped_fat
    data[:turn_pumped_fat] = turn_pumped_fat
    data[:total_pumped_fat] = total_pumped_fat
    data
  end

  def self.alarms(params)
    time_range, data = init(params, 'Diagrama de alarmas')
    return nil if time_range.nil?
    alarms = Alarm.where(created_at: time_range)
    alarms_count = alarms.count
    return nil if alarms_count == 0
    alarms_count_by_type = alarms.group(:alarm_type_id)
      .count
      .sort_by { |alarm_type_id, count| count }
      .reverse

    alarm_type_ids = alarms_count_by_type.map do |item|
      item[0]
    end
    alarm_types = AlarmType.where(id: alarm_type_ids)
      .pluck(:id, :code, :description)
      .reduce({}) do |hash, alarm_type|
        hash[alarm_type[0]] = {
          code: alarm_type[1],
          description: alarm_type[2]
        }
        hash
    end
    cumulative = 0
    alarms = alarms_count_by_type.map do |alarm_count|
      {
        code: alarm_types[alarm_count[0]][:code],
        frequency: alarm_count[1],
        cumulative_percentage: cumulative += alarm_count[1] / alarms_count * 100
      }
    end

    data[:alarms] = alarms
    data[:alarm_types] = alarm_types
    data
  end

  def self.motors(params)
    time_range, data = init(params, 'Motores')
    return nil if time_range.nil?
    return nil if MotorStat.where(created_at: time_range).empty?

    motors = Motor.pluck(:id, :name)
      .reduce({}) do |motors, motor|
        motors[motor[0]] = motor[1]
        motors
    end
    motors_stats = motors.map do |motor_id, motor_name|
      motor_stats = MotorStat.where(motor_id: motor_id, created_at: time_range)
        .pluck(:state, :created_at)
        .reduce(Hash.new { |hash, key| hash[key] = [] }) do |motor_stats, motor_stat|
          motor_stats[:states] << motor_stat[0]
          motor_stats[:timestamps] << motor_stat[1].to_time.to_i * 1000
          motor_stats
      end
      {motor_name: motor_name, motor_stats: motor_stats}
    end

    data[:motors_stats] = motors_stats
    data
  end

  def self.averages(params)
    time_range, data = init(params, 'Temperatura final, nivel de grasa, nivel de carga y presión interna')
    return nil if time_range.nil?

    final_temps = []
    fat_levels = []
    currents = []
    pressures = []
    24.times do |hour|
      final_temps << Stat.where(stat_type_id: 6)
        .where(created_at: get_hourly_range(time_range.begin, hour))
        .average(:value)
      fat_levels << Stat.where(stat_type_id: 2)
        .where(created_at: get_hourly_range(time_range.begin, hour))
        .average(:value)
      currents << Stat.where(stat_type_id: 3)
        .where(created_at: get_hourly_range(time_range.begin, hour))
        .average(:value)
      pressures << Stat.where(stat_type_id: 1)
        .where(created_at: get_hourly_range(time_range.begin, hour))
        .average(:value)
    end

    data[:final_temps] = final_temps
    data[:fat_levels] = fat_levels
    data[:currents] = currents
    data[:pressures] = pressures
    data
  end

  private

  def self.init(params, title)
    time_range = get_time_range(params)
    return nil if time_range.nil?

    data = {}
    data[:title] = title
    data[:start_time] = time_range.begin
    data[:end_time] =  time_range.end

    [time_range, data]
  end

  def self.get_hourly_range(start_time, hour)
    start_time + hour.hours .. start_time + (hour + 1).hours
  end

  def self.get_time_range(params)
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

  def self.turn_time_condition(turn)
    if turn.start_time < turn.end_time
      time_condition = 'TIME(created_at) BETWEEN TIME(?) AND TIME(?)'
    else
      time_condition = 'TIME(created_at) BETWEEN TIME(?) AND "23:59:59" OR TIME(created_at) BETWEEN "00:00:00" AND TIME(?)'
    end
  end
end
