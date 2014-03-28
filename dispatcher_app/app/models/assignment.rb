class Assignment < ActiveRecord::Base
  validates :booking_id, presence: true, uniqueness: true
  belongs_to :driver

  before_create :assign_driver

  private

    def assign_driver
      self.driver = Driver.first
    end
end
