json.extract! item, :id, :name, :description, :start_price, :created_at, :updated_at
json.url item_url(item, format: :json)
