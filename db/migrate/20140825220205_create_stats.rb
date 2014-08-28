class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.references :stat_type
      t.references :user
      t.float :value
      t.float :set_point
      t.boolean :auto
      t.timestamps
    end
  end
end