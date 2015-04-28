class AddMultipleIndexesToStatsAndMotorStats < ActiveRecord::Migration
  def change
    add_index :stats, [:stat_type_id, :created_at]
    add_index :motor_stats, [:motor_id, :created_at]
  end
end
