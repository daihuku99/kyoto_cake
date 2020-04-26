class AddIsValidToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :is_valid, :boolean, defalt: false
  end
end
