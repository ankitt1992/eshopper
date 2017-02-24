class ProductsController < ApplicationController
  def show
    @cart_item = CartItem.new
    @product = Product.find(params[:id])
    @similar_pictures = @product.pictures
    if user_signed_in?
      @cart_items = current_user.cart_items.all
    end
    @categories = Category.where(parent_id: nil)
    @brands = Brand.where(status: true)
    @category = @product.categories.find_by(parent_id: nil)
    @recommended_products = @product.products
  end
end
