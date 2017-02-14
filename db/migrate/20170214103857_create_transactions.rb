class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :stripe_email
      t.string :stripe_token_type
      t.string :paid

      t.timestamps null: false
    end
  end
end
