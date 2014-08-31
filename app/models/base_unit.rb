class BaseUnit < ActiveRecord::Base
  has_many :stat_types

  validates :unit, :description, presence: true

  before_destroy :check_stat_types

  def check_stat_types
    stat_types.empty?
  end

  def to_collection_select
    "#{description} (#{unit})"
  end
end