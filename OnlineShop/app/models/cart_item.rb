class CartItem < ActiveRecord::Base
  acts_as_shopping_cart_item_for :cart

  belongs_to :product, :foreign_key => 'item_id'
end