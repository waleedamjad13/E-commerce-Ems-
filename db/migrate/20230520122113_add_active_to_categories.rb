# frozen_string_literal: true

# migration for adding active(boolean) column to categories table
class AddActiveToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :active, :boolean, default: true
  end
end
