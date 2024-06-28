class User < ApplicationRecord
  enum role: { buyer: 'buyer', seller: 'seller' }

  has_secure_password
  has_one :buyer
  has_one :seller

  after_create :create_buyer

  private

  def create_buyer
    Buyer.create(user: self)
  end
end
