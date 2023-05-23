# frozen_string_literal: true

# model for category
class Category < ApplicationRecord
  extend QueryMethods

  has_many :products, dependent: :destroy
end
