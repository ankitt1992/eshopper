class Category < ActiveRecord::Base
  has_many :product_categories
  has_many :products, :through=> :product_categories
  has_many :subcategories, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :parent_category, :class_name => "Category", :foreign_key => "parent_id"
  has_many :brand_categories
  has_many :brands, :through=> :brand_categories
end