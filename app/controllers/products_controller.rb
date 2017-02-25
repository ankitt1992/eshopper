class ProductsController < ApplicationController

  before_action :set_brands
  before_action :initialize_cart_item

  def show
    @product = Product.find(params[:id])
    @similar_pictures = @product.pictures
    if user_signed_in?
      @cart_items = current_user.cart_items
    end
    @categories = Category.parent_categories
    @category = @product.categories.find_by(parent_id: nil)
    @recommended_products = @product.products
  end
end
