class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :delivery_order_id
      t.datetime :serving_date
      t.integer :meal_id
      t.integer :quantity, default: 0
      t.integer :unit_price, default: 0

      t.timestamps
    end
  end
end
