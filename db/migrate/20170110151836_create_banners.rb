class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :title
      t.text :description
      t.string :status

      t.timestamps null: false
    end
  end
end
