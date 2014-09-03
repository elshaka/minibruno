class Turn < ActiveRecord::Base
  validates :name, :start_time, :end_time, presence: true
end
