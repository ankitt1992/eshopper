class AddSubTotalToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :sub_total, :decimal
  end
end
