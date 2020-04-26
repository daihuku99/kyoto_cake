class Item < ApplicationRecord
	has_many :cart_items, dependent: :destroy
	belongs_to :genre
	attachment :image

  def tax_price
    (non_taxed_price * 1.1).floor
  end

	enum is_valid: {
		無効: true,
		有効: false
	}
end
