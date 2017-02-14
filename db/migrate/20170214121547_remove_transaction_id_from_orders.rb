class RemoveTransactionIdFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :transaction_id, :string
  end
end
