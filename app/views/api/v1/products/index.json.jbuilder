json.array! @products do |product|
  json.extract! product, :id, :title, :category, :description, :filename, :height, :width, :price, :rating, :created_at
end
