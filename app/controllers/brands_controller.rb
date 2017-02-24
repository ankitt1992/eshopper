class BrandsController < ApplicationController
  before_action :set_brand, only: [:index, :show]
  before_action :initialize_cart_item, only: [:index, :show]

  def index
    @categories = Category.parent_categories
    binding.pry
    @category = Category.new
    @products = @brand.products
  end

  def show
    @categories = Category.where(parent_id: nil)
    cat_id = params[:subcategory_id] || params[:category_id]
    @category = Category.find(cat_id)
    @products = @category.products.where(brand_id: @brand.id)

    if user_signed_in?
      @cart_items = current_user.cart_items
    end
  end

  private
    def set_brand
      @brand = Brand.find(params[:id])
      @brands = Brand.where(status: true)
    end

    def initialize_cart_item
      @cart_item = CartItem.new
    end
end
