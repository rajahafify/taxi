class Api::V1::UsersController < ApplicationController
  def create
    @user = User.find_or_create_by(params.require(:user).permit(:phone_number))
    if @user.save
      render json: { status: 'success', auth_token: @user.auth_token }
    else
      render json: { status: 'fail' }
    end
  end
end
