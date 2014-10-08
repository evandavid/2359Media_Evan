class HomeController < ApplicationController
  before_filter :extract_shopping_cart
  before_filter :auth_first, only: %w(purchase)

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

  def purchase
    if @cart.total.to_i > 0
        transaction = Transaction.add_data @cart, current_user
        redirect_to "http://localhost:4000/pay?my_token="+transaction.token+"&amount="+@cart.total.to_i.to_s
    else
        redirect_to root_path, flash: {warning: "Oops, your cart is empty."}
    end
  end

  def failed
    redirect_to root_path, flash: {warning: "Oops, you cannot complete this purcase. "+params[:reason]}
  end

  def success_pay
    transaction = Transaction.find_by_token(params[:my_token])
    transaction.done = true
    transaction.save

    @cart.clear
    redirect_to root_path, flash: {success: "Your order purchased successfully."}
  end

  private
  def get_product_by_id(id)
      Product.find_by_id id
  end

  private
  def auth_first
    unless current_user
        redirect_to root_path, flash: {warning: "Oops, you have to logged in first."}
    end
  end

  private
  def extract_shopping_cart
    shopping_cart_id = session[:shopping_cart_id]
    @cart = session[:shopping_cart_id] ? Cart.find(shopping_cart_id) : Cart.create
    session[:shopping_cart_id] = @cart.id
  end
end
