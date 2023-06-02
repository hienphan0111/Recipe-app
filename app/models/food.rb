class Food < ApplicationRecord
  validates :name, presence: true, length: { maximum: 300 }
  validates :measurement_unit, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  has_many :recipe_foods, dependent: :destroy
  has_many :inventory_foods, dependent: :destroy
end
