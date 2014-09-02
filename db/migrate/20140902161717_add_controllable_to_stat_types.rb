class AddControllableToStatTypes < ActiveRecord::Migration
  def change
    add_column :stat_types, :controllable, :boolean, default: false, null: false
  end
end
