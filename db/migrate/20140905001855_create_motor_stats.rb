class CreateMotorStats < ActiveRecord::Migration
  def change
    create_table :motor_stats do |t|
      t.references :motor
      t.boolean :state
      t.timestamps
    end
  end
end
