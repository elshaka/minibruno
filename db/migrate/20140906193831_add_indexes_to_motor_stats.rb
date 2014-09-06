class AddIndexesToMotorStats < ActiveRecord::Migration
  def change
    add_index :motor_stats, :motor_id
    add_index :motor_stats, :created_at
  end
end
