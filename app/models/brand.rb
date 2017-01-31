class Brand < ActiveRecord::Base
  has_many :brand_categories
  has_many :categories, :through=> :brand_categories
  has_many :products
end
