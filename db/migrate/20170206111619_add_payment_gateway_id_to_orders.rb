class AddPaymentGatewayIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :payment_gateway_id, :integer
  end
end
