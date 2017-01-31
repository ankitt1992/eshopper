class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

before_save { |ci| ci.total = ci.quantity * ci.product.price }
  # default_scope -> {where(user_id: current_user.id)}
end
