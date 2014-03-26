class User < ActiveRecord::Base
  validates :phone_number, presence: true, uniqueness: true
  validates :auth_token, presence: true
  before_validation :generate_auth_token

  private

    def generate_auth_token
      begin
        self.auth_token = SecureRandom.hex
      end while self.class.exists?(auth_token: auth_token)
    end
end
