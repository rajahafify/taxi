class AddDriverIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :driver_assigned, :boolean, default:false
    add_column :bookings, :driver_id, :integer
  end
end
