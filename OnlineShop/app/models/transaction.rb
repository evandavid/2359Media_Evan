class Transaction < ActiveRecord::Base
  belongs_to :user
  # has_many :transaction_details

  validates :user_id, presence: true
  validates :fee, presence: true

  before_create :generate_token

  def self.add_data(cart, current_user)
    transaction = self.new
    transaction.user_id = current_user.id
    transaction.done = false
    transaction.fee = cart.total
    transaction.save
    transaction
  end

  protected
  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Transaction.exists?(token: random_token)
    end
  end
end
