class PreOrder < ApplicationRecord

  belongs_to :member
  belongs_to :item

  validates :amount, presence: true
  validates :visit_day, presence: true
  validates :visit_time, presence: true
  validates :purpose, presence: true

  enum status: { before_visit: 0, visit: 1, cancel: 2 }

  def order_full_name
    last_name + ' ' + first_name
  end

  def order_full_name_kana
    last_name_kana + ' ' + first_name_kana
  end

  def self.search_for(content, method)
    if method == 'partial'
      PreOrder.where('name LIKE?', '%'+content+'%')
    elsif method == 'perfect'
      PreOrder.where(name: content)
    elsif method == 'forward'
      PreOrder.where('name LIKE?', content+'%')
    else
      PreOrder.where('name LIKE?', '%'+content)
    end
  end
end
