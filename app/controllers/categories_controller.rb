class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @categories = Category.parent_categories
    @cart_item = CartItem.new
    if params[:subcategory_id].present?
      @subcategory = Category.find(params['subcategory_id'])
      @products = @subcategory.products
    elsif params[:id].present?
      @products = @category.products
    end
    
    if user_signed_in?
      @cart_items = current_user.cart_items
      @wishlists = current_user.wishlists
    end
  end
end
