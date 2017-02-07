class RemoveAmountFromOrderItems < ActiveRecord::Migration
  def change
    remove_column :order_items, :amount, :float
  end
end
