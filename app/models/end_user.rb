class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :deliveries, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  enum is_deleted: {
    退会済み: true,
    有効: false
  }

  def full_name
    self.first_name + self.last_name
  end

  def full_kana_name
    self.first_kana_name + self.last_kana_name
  end

  def total_price(tax)
    # if self.cart_items.exists?
    sum = 0
      self.cart_items.each do |cart_item|
        sum += (cart_item.item.non_taxed_price * cart_item.quantity * tax).floor
      end
      return sum
    # else
    #   return 0
    # end
  end

  def add_item?(item_id)
    self.cart_items.where(item_id: item_id).exists?
  end

end
