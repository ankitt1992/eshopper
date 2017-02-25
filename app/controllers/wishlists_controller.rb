class WishlistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wishlist, only: [:destroy]
  before_action :intialize_current_user_wishlist, only: [:index, :create, :destroy]
  before_action :set_current_user_cart_items, only: [:index]

  def index
    @cart_item = current_user.cart_items.new
  end

  def create
    @wishlist = @wishlists.find_or_initialize_by(product_id: params[:product_id])
    @product = @wishlist.product
    respond_to do |format|
      if @wishlist.save
        format.html { redirect_to wishlists_path, notice: 'Wishlist was successfully created.' }
        format.js
      else
        format.html { redirect_to wishlists_path, alert: 'Wishlist was not created.' }
        format.js
      end
    end
  end

  def destroy
    @product = @wishlist.product
    @wishlist.destroy
    respond_to do |format|
      format.html { redirect_to wishlists_url, notice: 'Wishlist was successfully deleted.' }
      format.js
    end
  end

  private
    def set_wishlist
      @wishlist = current_user.wishlists.find(params[:id])
    end

    def intialize_current_user_wishlist
      @wishlists = current_user.wishlists.order('created_at DESC')
    end
end
