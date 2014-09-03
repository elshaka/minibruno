class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.time :start_time
      t.time :end_time
      t.string :description

      t.timestamps
    end
  end
end
