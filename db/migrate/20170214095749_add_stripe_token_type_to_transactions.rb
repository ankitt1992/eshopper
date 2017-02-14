class AddStripeTokenTypeToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :stripe_token_type, :string
  end
end
