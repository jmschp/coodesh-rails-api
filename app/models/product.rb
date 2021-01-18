PRODUCT_CATEGORY = ['dairy', 'fruit', 'vegetable', 'bakery', 'vegan', 'meat']
PRODUCT_RATING = [0, 1, 2, 3, 4, 5]

class Product < ApplicationRecord
  has_one_attached :photo, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :category, presence: true, inclusion: { in: PRODUCT_CATEGORY }
  validates :description, length: { maximum: 500 }
  validates :price, presence: true
  validates :rating, presence: true, inclusion: { in: PRODUCT_RATING }
end
