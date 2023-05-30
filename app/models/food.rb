class Food < ApplicationRecord
  validates :name, presence: true, length: { maximum: 300 }
  validates :meaurement_unit, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :price, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :expiration_date, presence: true
  validates :user_id, presence: true

  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :recipe_foods, foreign_key: 'foods_id', dependent: :destroy
end
