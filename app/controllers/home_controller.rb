class HomeController < ApplicationController

  before_action :set_brands
  before_action :initialize_cart_item

  def index
    @banners = Banner.all
    @categories = Category.where(parent_id: nil)
    @category = Category.first
    if @category.present?
      @products = @category.products
    end

    if user_signed_in?
      @wishlist = current_user.wishlists.new
      @wishlists = current_user.wishlists
      @cart_items = current_user.cart_items
    end
  end
end
