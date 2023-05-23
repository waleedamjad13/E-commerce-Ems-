class AddUserReffToCarts < ActiveRecord::Migration[6.0]
  def change
    add_reference :carts, :user, foriegn_key: true
  end
end
