class Inventory < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
end

class Inventory < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_many :inventory_foods
end
