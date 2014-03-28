class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :booking_id
      t.string :latitude
      t.string :longitude
      t.integer :driver_id

      t.timestamps
    end
  end
end
