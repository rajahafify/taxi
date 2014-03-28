class RemoveLatitudeAndLongitudeFromAssignments < ActiveRecord::Migration
  def change
    remove_column :assignments, :latitude, :string
    remove_column :assignments, :longitude, :string
  end
end
