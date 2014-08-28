class BaseUnit < ActiveRecord::Base
  has_many :stat_types

  validates :unit, :description, presence: true

  def to_collection_select
    "#{description} (#{unit})"
  end
end