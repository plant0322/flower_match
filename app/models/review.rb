class Review < ApplicationRecord
  belongs_to :pre_order

  validates :content, presence: true
  validates :pre_order_id, uniqueness: true

end
