class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  before_save { |ci| ci.total = ci.quantity * ci.product.price }

  def self.calculate_sum(cart_items)
    cart_items = cart_items
    cart_items_total = cart_items.sum(:total)
    vat = 0.04 * cart_items_total
    if cart_items_total < 500
      shipping_cost = 40.to_f
      grand_total = cart_items_total + vat + shipping_cost
    else
      shipping_cost = 'Free'
      grand_total = cart_items_total + vat
    end

    [cart_items_total, vat, shipping_cost, grand_total]
  end
  
  # default_scope -> {where(user_id: current_user.id)}
end
