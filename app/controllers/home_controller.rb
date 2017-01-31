class HomeController < ApplicationController
  def index
    @banners = Banner.all
    # @category = nil
    # binding.pry
    # @categories = Category.find(:all, :conditions => {:parent_id => nil } )
    @categories = Category.all.where(parent_id: nil)
    @category = Category.first
    if @category.present?
      @subcategory = @category.subcategories.last
      @products = @subcategory.products.limit(8)
    end

    @cart_item = CartItem.new

    if user_signed_in?
      @cart_items = current_user.cart_items.all
    end

    @brands = Brand.where(status: true).all
  end
end
