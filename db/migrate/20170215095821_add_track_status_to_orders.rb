class AddTrackStatusToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :track_status, :string
  end
end
