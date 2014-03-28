class Api::V1::AssignmentsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]
  def create
    assignment = Assignment.new(assignment_params)
    if assignment.save
      render json: { status: 'success', driver_id: assignment.driver.id }
    else
      render json: { status: 'fail', errors: assignment.errors.messages }
    end
  end

  private

    def assignment_params
      params.permit(:booking_id, :latitude, :longitude)
    end
end
