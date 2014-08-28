class StatType < ActiveRecord::Base
  belongs_to :base_unit
  has_many :stats

  before_destroy :check_stats

  def check_stats
    if stats.any?
      errors[:base] << "no se puede eliminar el tipo de estadística porque tiene registros asociados"
    end
    false
  end
end