class Alarm < ActiveRecord::Base
  belongs_to :alarm_type
  belongs_to :user
end
