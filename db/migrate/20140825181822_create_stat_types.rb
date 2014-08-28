class CreateStatTypes < ActiveRecord::Migration
  def change
    create_table :stat_types do |t|
      t.references :base_unit
      t.string :description
      t.timestamps
    end
  end
end