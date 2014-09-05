class AddCodeToAlarmTypes < ActiveRecord::Migration
  def change
    add_column :alarm_types, :code, :string
  end
end
