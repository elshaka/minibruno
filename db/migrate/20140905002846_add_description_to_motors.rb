class AddDescriptionToMotors < ActiveRecord::Migration
  def change
    add_column :motors, :description, :string
  end
end
