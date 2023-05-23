# frozen_string_literal: true

# migration for adding category_id to products table as a foriegn key
class AddCategoryReferenceToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :category, foriegn_key: true
  end
end
