class AddStripeEmailToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :stripe_email, :string
  end
end
