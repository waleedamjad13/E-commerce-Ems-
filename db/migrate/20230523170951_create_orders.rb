# frozen_string_literal: true

# migration for creating order
class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.timestamps
    end
  end
end
