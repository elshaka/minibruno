class Stat < ActiveRecord::Base
  belongs_to :stat_type
  belongs_to :user

  validates :value, numericality: true
  validates :set_point, numericality: {allow_nil: true}
  validates :stat_type_id, presence: true

  def self.get_dashboard_stats
    now = Time.now

    init_temp = Stat.where(stat_type_id: 4).last
    mid_temp = Stat.where(stat_type_id: 5).last
    final_temp = Stat.where(stat_type_id: 6).last
    vapor_temp = Stat.where(stat_type_id: 7).last

    {
      init_temp: check_stat(now, init_temp),
      mid_temp: check_stat(now, mid_temp),
      final_temp: check_stat(now, final_temp),
      vapor_temp: check_stat(now, vapor_temp)
    }
  end

  private

  def self.check_stat(now, stat)
    if now - stat.created_at < 300
      {
        value: stat.value.round,
        set_point: stat.set_point,
        auto: stat.auto
      }
    else
      nil
    end
  end
end
