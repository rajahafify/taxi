class Api::V1::DriversController < ApplicationController
  def details
    driver = Driver.find(params[:id])
    render json: { driver_name: driver.name, driver_phone_number: driver.phone_number }
  end
end
