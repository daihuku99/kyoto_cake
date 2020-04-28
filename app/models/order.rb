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
end