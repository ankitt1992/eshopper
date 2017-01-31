class AddStatusToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :status, :boolean
  end
end
