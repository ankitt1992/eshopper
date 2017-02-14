class AddPaidToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :paid, :string
  end
end
