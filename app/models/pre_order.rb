class PreOrder < ApplicationRecord

  belongs_to :member
  belongs_to :item

  validates :visit_day, presence: true
  validates :visit_time, presence: true
  validates :purpose, presence: true

  def order_full_name
    last_name + ' ' + first_name
  end

  def order_full_name_kana
    last_name_kana + ' ' + first_name_kana
  end
end
