PRODUCT_CATEGORY = ['dairy', 'fruit', 'vegetable', 'bakery', 'vegan', 'meat']
PRODUCT_RATING = [0, 1, 2, 3, 4, 5]

class Product < ApplicationRecord
  has_one_attached :image, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :category, presence: true, inclusion: { in: PRODUCT_CATEGORY }
  validates :description, length: { maximum: 500 }
  validates :price, presence: true
  validates :rating, presence: true, inclusion: { in: PRODUCT_RATING }

  after_save :update_image_url

  private

  def update_image_url
    self.update_columns(image_url: self.image.url) if self.image.attached?
  end
end
