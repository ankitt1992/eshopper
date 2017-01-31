class AddTotalToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :total, :decimal
  end
end
