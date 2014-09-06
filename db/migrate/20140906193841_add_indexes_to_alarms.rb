class AddIndexesToAlarms < ActiveRecord::Migration
  def change
    add_index :alarms, :alarm_type_id
    add_index :alarms, :created_at
  end
end
