# frozen_string_literal: true

# model for user
class Product < ApplicationRecord
  extend QueryMethods

  belongs_to :category

  has_many :order_items, dependent: :destroy

  has_many :discount_products, dependent: :destroy
  has_many :discounts, through: :discount_products

  has_one_attached :header_image
  has_many_attached :images

  enum status: {
    pending: 0,
    draft: 1,
    publish: 2
  }
end
