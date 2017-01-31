module CartItemsHelper
	def grand_total
		if current_user.present?
			current_user.cart_items.sum(:total)
		end
	end
end
