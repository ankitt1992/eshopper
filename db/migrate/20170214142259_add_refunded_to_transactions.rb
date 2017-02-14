class AddRefundedToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :refunded, :boolean
  end
end
