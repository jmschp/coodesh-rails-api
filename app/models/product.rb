PRODUCT_TYPE = ['dairy', 'fruit', 'vegetable', 'bakery', 'vegan', 'meat']
PRODUCT_RATING = [1, 2, 3, 4, 5]
class Product < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :type, presence: true, inclusion: { in: PRODUCT_TYPE }
  validates :description, length: { maximum: 500 }
  validates :price, presence: true
  validates :rating, presence: true, inclusion: { in: PRODUCT_RATING }
end
