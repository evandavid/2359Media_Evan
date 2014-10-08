class TransactionDetail < ActiveRecord::Base
  belongs_to :transaction
  belongs_to :product

  validates :product_id, presence: true
  validates :amount, presence: true, numericality: { only_integer: true }
end
