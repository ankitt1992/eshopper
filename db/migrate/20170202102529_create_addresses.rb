class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :user, index: true, foreign_key: true
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :address1
      t.string :address2
      t.string :postal_code
      t.string :country
      t.string :state
      t.string :mobile_no

      t.timestamps null: false
    end
  end
end
