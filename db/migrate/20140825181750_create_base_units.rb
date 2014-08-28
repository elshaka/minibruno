class CreateBaseUnits < ActiveRecord::Migration
  def change
    create_table :base_units do |t|
      t.string :unit
      t.string :description
      t.timestamps
    end
  end
end
