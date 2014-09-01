class Stat < ActiveRecord::Base
  belongs_to :stat_type
  belongs_to :user

  validates :value, numericality: true
  validates :set_point, numericality: {allow_nil: true}
  validates :stat_type_id, presence: true
end
