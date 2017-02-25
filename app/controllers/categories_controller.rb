class CategoriesController < ApplicationController

  before_action :set_brands
  before_action :initialize_cart_item

  def show
    @category = Category.find(params[:id])
    @categories = Category.parent_categories
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
