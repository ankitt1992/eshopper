class Product < ActiveRecord::Base
  has_many :pictures, as: :imageable
  has_many :product_categories
  has_many :categories, :through=> :product_categories
  belongs_to :brand
  has_many :order_items


  has_and_belongs_to_many(:products,
    :join_table => "recommended_products",
    :dependent  => :destroy,
    :foreign_key => "product_id",
    :association_foreign_key => "recommended_product_id")
  # has_many :wishlists
  default_scope{where(status: true)}
end
