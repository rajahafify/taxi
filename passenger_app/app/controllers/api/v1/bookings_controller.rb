class Api::V1::BookingsController < ApplicationController
  before_action :authorize_user
  def create
    booking = @user.bookings.build(booking_params)
    if booking.save
      render json: { status: 'success', booking_id: booking.id }
    else
      render json: { status: 'fail' }
    end
  end

  private
    def authorize_user
      @user = User.find_by phone_number: params[:user][:phone_number]
      head :unauthorized unless @user == User.find_by(auth_token: params[:user][:auth_token])
    end

    def booking_params
      params.require(:booking).permit(:latitude, :longitude)
    end

end
