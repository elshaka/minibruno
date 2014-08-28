class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.references :user
      t.string :description
      t.datetime :ended_at
      t.timestamps
    end
  end
end