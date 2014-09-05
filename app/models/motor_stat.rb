class MotorStat < ActiveRecord::Base
  belongs_to :motor
  validates :motor_id, presence: true
end
