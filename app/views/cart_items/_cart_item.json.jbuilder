json.extract! cart_item, :id, :quantity, :product_id, :user_id, :created_at, :updated_at
json.url cart_item_url(cart_item, format: :json)