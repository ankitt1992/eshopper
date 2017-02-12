class Wishlist < ActiveRecord::Base
	has_many :product_wishlists
	has_many :products, :through=> :product_wishlists

end
