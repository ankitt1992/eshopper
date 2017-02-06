class AddShippingChargesToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_charges, :decimal
  end
end
