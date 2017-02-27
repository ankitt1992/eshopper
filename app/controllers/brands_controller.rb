class BrandsController < ApplicationController
  before_action :set_brands, :set_brand, :find_categories, only: [:index, :show]
  before_action :initialize_cart_item, :set_current_user_cart_items, only: [:index, :show]

  def index
    @category = Category.new
    @products = @brand.products
  end

  def show
    cat_id = params[:subcategory_id] || params[:category_id]
    @category = Category.find(cat_id)
    @products = @category.products.where(brand_id: @brand.id)

  end

  private
    def set_brand
      @brand = Brand.find(params[:id])
    end

    def find_categories
      @categories = Category.parent_categories
    end
    
end
