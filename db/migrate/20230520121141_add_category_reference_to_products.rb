class AddCategoryReferenceToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :category, foriegn_key: true
  end 
end
