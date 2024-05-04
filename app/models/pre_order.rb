class PreOrder < ApplicationRecord

  belongs_to :member
  belongs_to :item

  validates :visit_day, presence: true
  validates :visit_time, presence: true
  validates :purpose, presence: true
  validates :note, presence: true
end
