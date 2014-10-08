class HomeController < ApplicationController
  before_filter :extract_shopping_cart

  def index
    @products = Product.available
  end

  def detail
    @product = get_product_by_id params[:id]
  end

  def cart
    product = get_product_by_id params[:id]
    coupon = product.coupon.nil? ? 0 : product.coupon.coupon
    @cart.add product, (product.price.to_i - coupon), 1
    redirect_to request.referer
  end

  def cart_detail
  end

  def delete_cart
    product = get_product_by_id params[:id]
    item = CartItem.find params[:item_id]
    @cart.remove(product, item.quantity)
    redirect_to request.referer
  end

  private
  def get_product_by_id(id)
      Product.find_by_id id
  end

  private
  def extract_shopping_cart
    shopping_cart_id = session[:shopping_cart_id]
    @cart = session[:shopping_cart_id] ? Cart.find(shopping_cart_id) : Cart.create
    session[:shopping_cart_id] = @cart.id
  end
end
