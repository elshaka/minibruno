class AddIndexToStatsCreatedAt < ActiveRecord::Migration
  def change
    add_index :stats, :created_at
  end
end
