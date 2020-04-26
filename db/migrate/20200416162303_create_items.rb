class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :image_id
      t.text :detail
      t.integer :non_taxed_price
      t.integer :genre_id
      t.timestamps
    end
  end
end
