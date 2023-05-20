class CreateDiscountProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :discount_products do |t|
      t.integer :discount_id
      t.integer :product_id
    end
  end
end
