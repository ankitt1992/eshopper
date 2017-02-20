class CreateUsedCoupons < ActiveRecord::Migration
  def change
    create_table :used_coupons do |t|
      t.integer :user_id
      t.integer :order_id
      t.integer :coupon_id

      t.timestamps null: false
    end
  end
end
