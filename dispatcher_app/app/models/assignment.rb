class Assignment < ActiveRecord::Base
  validates :booking_id, presence: true
end
