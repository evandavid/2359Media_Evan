class Coupon < ActiveRecord::Base
  belongs_to :product

  validates :product_id, presence: true
  validates :coupon, presence: true
end
