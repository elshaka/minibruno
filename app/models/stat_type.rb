class StatType < ActiveRecord::Base
  belongs_to :base_unit
  has_many :stats

  validates :description, presence: true
  before_destroy :check_stats

  scope :controllable, -> { where controllable: true }

  def check_stats
    stats.empty?
  end
end