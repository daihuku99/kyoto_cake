class CartItem < ApplicationRecord
	belongs_to :item
	belongs_to :end_user

  def tax_price
    (self.item.non_taxed_price * 1.1).floor
  end

  def sub_total
    ((self.item.non_taxed_price * 1.1).floor) * self.quantity
  end


  # def total_price
  #   if self.cart_items.exists?
  #   sum = 0
  #     self.cart_items.each do |cart_item|
  #       sum += cart_item.item.non_taxed_price
  #     end
  #     return sum
  #   else
  #     return 0
  #   end
  # end

end
