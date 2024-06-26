class Shop < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :favorite_shops, dependent: :destroy
  has_many :shop_messages, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_one_attached :shop_image

  validates :shop_image, presence: true
  validates :name, presence: true
  validates :name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :introduction, presence: true
  validates :representative_name, presence: true
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :prefecture_code, presence: true
  validates :address, presence: true
  validates :opening_hour, presence: true
  validates :holiday, presence: true
  validates :parking, presence: true
  validates :note, presence: true
  validates :payment_method, presence: true
  validates :direction, presence: true
  validates :telephone_number, presence: true, uniqueness: true, format: { with: /\A\d{10,11}\z/ }
  validates :email, presence: true

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
  JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def get_shop_image(width, height)
    shop_image.variant(resize_to_fill: [width, height]).processed
  end

  def favorite_shop_by?(member)
    favorite_shops.exists?(member_id: member.id)
  end

  scope :active_shop, -> { where(is_active: true) }

  # ゲストログイン用
  GUEST_SHOP_EMAIL = 'guest_shop@example.com'

  def self.guest
    find_or_create_by!(email: GUEST_SHOP_EMAIL) do |shop|
      shop.password = SecureRandom.urlsafe_base64
      shop.name = '【お試し】Flower Shop'
      shop.name_kana = 'オタメシフラワーショップ'
      shop.introduction = '※こちらは動作体験用のお試しアカウントです。'
      shop.representative_name = 'お試し花子'
      shop.postal_code = '0000000'
      shop.prefecture_code = "13"
      shop.address = '△△市□□町0-0'
      shop.opening_hour = '10:00～17:00'
      shop.holiday = '火曜日'
      shop.parking = '駐車場あり（3台分）'
      shop.note = 'その他'
      shop.payment_method = '現金/Visa／Mastercard／JCB／American Express／PayPay'
      shop.direction = 'スーパーの向かい側にある白い建物です'
      shop.telephone_number = '00000000000'
      shop.is_active = 'true'
      shop.shop_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample.jpg"), filename: "sample.jpg")
    end
  end

  def guest_shop?
    email == GUEST_SHOP_EMAIL
  end
end
