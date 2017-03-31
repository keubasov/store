class AddPhoneToCart < ActiveRecord::Migration[5.0]
  def change
    add_column :carts, :phone, :string
  end
end
