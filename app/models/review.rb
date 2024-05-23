class Review < ApplicationRecord
  belongs_to :pre_order

  validates :content, presence: true, length: { maximum: 300 }
  validates :pre_order_id, uniqueness: true

end
