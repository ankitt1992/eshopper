class Product < ActiveRecord::Base
  has_many :pictures, as: :imageable
  has_many :product_categories
  has_many :categories, :through=> :product_categories
  belongs_to :brand
  has_many :order_items

  default_scope{where(status: true)}
end
