# frozen_string_literal: true

# migration for creating cart
class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts, &:timestamps
  end
end
