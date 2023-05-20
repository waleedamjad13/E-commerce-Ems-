# frozen_string_literal: true

# model for user
class Product < ApplicationRecord
  extend QueryMethods

  has_one_attached :header_image
  has_many_attached :images
  belongs_to :user

  has_and_belongs_to_many :discounts
  enum status: {
    pending: 0,
    draft: 1,
    publish: 2
  }
end
