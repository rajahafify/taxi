class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]
  def create
    @user = User.find_or_create_by(params.require(:user).permit(:phone_number))
    if @user.save
      render json: { status: 'success', auth_token: @user.auth_token }
    else
      render json: { status: 'fail' }
    end
  end
end
