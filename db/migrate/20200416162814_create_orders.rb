class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :end_user_id
      t.integer :postage
      t.integer :payment_type
      t.string :direction
      t.string :postcode
      t.string :address
      t.integer :total_price
      t.decimal :tax
      t.integer :order_status
      t.timestamps
    end
  end
end
