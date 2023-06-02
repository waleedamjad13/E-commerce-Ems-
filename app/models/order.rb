# frozen_string_literal: true

# model for order
class Order < ApplicationRecord
  extend QueryMethods
  belongs_to :user
  has_many :order_items, dependent: :destroy
  belongs_to :discount, optional: true

  validates :address, presence: true


end
