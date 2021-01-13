# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'

filepath = 'products.json'

serialized_products = File.read(filepath)

products = JSON.parse(serialized_products)

products.each do |product|
  Product.create!(
    title: product['title'],
    category: product['type'],
    description: product['description'],
    price: product['price'],
    rating: product['rating']
  )
end
