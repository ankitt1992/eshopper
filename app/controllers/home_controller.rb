class HomeController < ApplicationController
  def index
    @banners = Banner.all
    @categories = Category.where(parent_id: nil)
    @category = Category.first
    if @category.present?
      @products = @category.products
    end

    @cart_item = CartItem.new
    if user_signed_in?
      @wishlist = current_user.wishlists.new
      @wishlists = current_user.wishlists
      @cart_items = current_user.cart_items
    end
  end
end
