class DiscountProduct < ApplicationRecord
  belongs_to :product
  belongs_to :discount
end