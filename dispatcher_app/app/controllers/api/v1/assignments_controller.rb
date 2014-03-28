class Api::V1::AssignmentsController < ApplicationController
  def create
    assignment = Assignment.new(assignment_params)
    if assignment.save
      render json: { status: 'success', assignment_id: assignment.id }
    else
      render json: { status: 'fail', errors: assignment.errors.messages }
    end
  end

  private

    def assignment_params
      params.require(:assignment).permit(:booking_id, :latitude, :longitude)
    end
end
