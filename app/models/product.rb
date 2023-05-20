# frozen_string_literal: true

# model for user
class Product < ApplicationRecord
  extend QueryMethods

  has_one_attached :header_image
  has_many_attached :images
  belongs_to :user

  has_many :discount_products
  has_many :discounts, through: :discount_products

  enum status: {
    pending: 0,
    draft: 1,
    publish: 2
  }
end
