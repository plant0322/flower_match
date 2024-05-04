class Shop < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_one_attached :profile_image

  validates :name, presence: true
  validates :name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :introduction, presence: true
  validates :representative_name, presence: true
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :opening_hour, presence: true
  validates :holiday, presence: true
  validates :parking, presence: true
  validates :note, presence: true
  validates :payment_method, presence: true
  validates :direction, presence: true
  validates :telephone_number, presence: true, format: { with: /\A\d{10,11}\z/ }
  validates :email, presence: true
end
