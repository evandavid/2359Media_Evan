class Transaction < ActiveRecord::Base
  belongs_to :user
  # has_many :transaction_details

  validates :user_id, presence: true
  validates :fee, presence: true
end
