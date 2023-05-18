# frozen_string_literal: true

# model for user
class Product < ApplicationRecord
  extend QueryMethods

  has_one_attached :header_image
  has_many_attached :images

  enum status: {
    pending: 0,
    draft: 1,
    publish: 2
  }
end
