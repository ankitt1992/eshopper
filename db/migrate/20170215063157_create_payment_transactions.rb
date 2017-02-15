class CreatePaymentTransactions < ActiveRecord::Migration
  def change
    create_table :payment_transactions do |t|
      t.integer :order_id
      t.string :stripe_email
      t.string :stripe_token
      t.string :stripe_token_type
      t.decimal :amount
      t.string :charge_id
      t.string :paid
      t.boolean :refunded
      t.date :refunded_date

      t.timestamps null: false
    end
  end
end

