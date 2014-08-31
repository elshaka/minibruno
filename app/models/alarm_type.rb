class AlarmType < ActiveRecord::Base
  has_many :alarms

  validates :description, presence: true

  before_destroy :check_alarms

  def check_alarms
    alarms.empty?
  end
end
