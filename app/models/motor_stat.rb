class MotorStat < ActiveRecord::Base
  belongs_to :motor
  validates :motor_id, :state, presence: true
end
