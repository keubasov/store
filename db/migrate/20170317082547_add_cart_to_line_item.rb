class AddCartToLineItem < ActiveRecord::Migration[5.0]
  def change
    add_reference :line_items, :cart, foreign_key: false
  end
end
