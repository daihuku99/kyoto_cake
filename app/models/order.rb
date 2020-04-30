class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
	belongs_to :end_user

	enum order_status: {
		入金待ち: 0,
		入金確認: 1,
		製作中: 2,
		発送準備中: 3,
		発送済み: 4
	}

  enum payment_type: {
    クレジットカード: 0,
    銀行振り込み: 1
  }

  def sum
    sum = 0
    self.order_details.each do |order_detail|
      sum += order_detail.quantity
    end
    return sum
  end

  def new_order(user)
    Order.transaction do
      self.save!
      user.cart_items.each do |cart_item|
          order_detail = OrderDetail.new
          order_detail.item_id = cart_item.item.id
          order_detail.price = cart_item.item.non_taxed_price
          order_detail.item_status = 0
          order_detail.quantity = cart_item.quantity
          order_detail.order_id = self.id
          order_detail.save
      end
      user.cart_items.destroy_all
    end
  end
end