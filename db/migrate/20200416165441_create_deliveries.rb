class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|
      t.integer :end_user_id
      t.string :postcode
      t.string :direction
      t.string :address
      t.timestamps
    end
  end
end
