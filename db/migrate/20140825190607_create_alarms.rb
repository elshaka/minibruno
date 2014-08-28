class CreateAlarms < ActiveRecord::Migration
  def change
    create_table :alarms do |t|
      t.references :alarm_type
      t.references :user
      t.timestamps
    end
  end
end