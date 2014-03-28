class ChangeLatitudeAndLongitudeToUseFloatsInDrivers < ActiveRecord::Migration
  def change
    change_column :drivers, :latitude, :float
    change_column :drivers, :longitude, :float

    Driver.all.each do |driver|
      driver.latitude.to_f
      driver.longitude.to_f
      driver.save
    end
  end
end
