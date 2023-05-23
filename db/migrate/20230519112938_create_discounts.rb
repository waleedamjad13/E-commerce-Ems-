# frozen_string_literal: true

# table for discounts
class CreateDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :discounts do |t|
      t.string :name
      t.integer :value

      t.timestamps
    end
  end
end
