json.array! @products do |product|
  json.extract! product, :id, :title, :category, :description, :price, :rating, :created_at
end
