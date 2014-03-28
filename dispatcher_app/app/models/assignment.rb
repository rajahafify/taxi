class Assignment < ActiveRecord::Base
  validates :booking_id, presence: true, uniqueness: true
end
