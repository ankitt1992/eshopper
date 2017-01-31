class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.string :short_description
      t.text :long_description
      t.decimal :price
      t.boolean :status
      t.integer :quantity
      t.string :meta_title
      t.text :meta_description
      t.text :meta_keywords

      t.timestamps null: false
    end
  end
end
