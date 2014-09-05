class CreateMotors < ActiveRecord::Migration
  def change
    create_table :motors do |t|
      t.string :name

      t.timestamps
    end
  end
end
