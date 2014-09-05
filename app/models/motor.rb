class Motor < ActiveRecord::Base
  has_many :motor_stats
  validates :name, :description, presence: true
  before_destroy :check_stats

  def check_stats
    motor_stats.empty?
  end
end
