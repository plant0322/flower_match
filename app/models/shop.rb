class Shop < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_one_attached :shop_image

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

  def get_shop_image(width, height)
    unless shop_image.attached?
      file_path = Rails.root.join('app/assets/images/sample.jpg')
      shop_image.attach(io: File.open(file_path), filename: 'sample.jpg', content_type: 'image/jpeg')
    end
    shop_image.variant(resize_to_limit: [width, height]).processed
  end
end
