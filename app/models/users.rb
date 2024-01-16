class Users < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :api_key, presence: true, unless: :new_record?

  before_validation :set_api_key

  private

  def set_api_key
    self.api_key ||= SecureRandom.base64.tr('+/=', 'Qrt')
  end
end
