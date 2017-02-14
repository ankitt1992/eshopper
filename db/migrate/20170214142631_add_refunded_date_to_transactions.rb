class AddRefundedDateToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :refunded_date, :date
  end
end
