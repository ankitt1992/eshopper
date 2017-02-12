class CreateProductWishlists < ActiveRecord::Migration
  def change
    create_table :product_wishlists do |t|
      t.integer :wishlist_id
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
