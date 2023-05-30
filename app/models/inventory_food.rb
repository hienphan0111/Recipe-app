class InventoryFood < ApplicationRecord
  validates :quantity, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }, allow_nil: true
  belongs_to :inventory
  belongs_to :food
end
