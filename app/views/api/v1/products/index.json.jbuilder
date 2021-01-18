json.array! @products do |product|
  json.extract! product, :id, :title, :category, :description, :filename, :height, :width, :price, :rating, :image_url, :created_at
end
