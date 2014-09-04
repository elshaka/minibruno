class AddIndexToStatsStatTypeId < ActiveRecord::Migration
  def change
    add_index :stats, :stat_type_id
  end
end
