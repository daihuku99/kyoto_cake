class Genre < ApplicationRecord
  has_many :items, dependent: :destroy

  enum is_valid: {
    無効: true,
    有効: false
  }
end
