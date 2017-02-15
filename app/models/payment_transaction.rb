class PaymentTransaction < ActiveRecord::Base
  # self.table_name = "transactions"
  belongs_to :order
end
