class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items

  # before_save :update_sub_total

  # def sub_total
  #   order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  # end

  # def update_sub_total
  #   binding.pry
  #   self[:sub_total] = sub_total
  # end
end
