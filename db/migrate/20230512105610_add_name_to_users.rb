# frozen_string_literal: true

# migration for adding ccustom fields(first and lastname) to user
class AddNameToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :firstname
      t.string :lastname
      t.boolean :admin, default: false
    end
  end
end
