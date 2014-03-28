require 'spec_helper'

describe Api::V1::AssignmentsController do
  describe "create" do
    it "should create assignment" do
      expect do
        post :create, assignment: { booking_id: 1 }
      end.to change(Assignment, :count).by 1
    end
  end
end
