class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
