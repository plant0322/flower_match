class Shop < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :favorite_shops, dependent: :destroy
  has_one_attached :shop_image

  validates :shop_image, presence: true
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
  validates :telephone_number, presence: true, uniqueness: true, format: { with: /\A\d{10,11}\z/ }
  validates :email, presence: true

  def get_shop_image(width, height)
    unless shop_image.attached?
      file_path = Rails.root.join('app/assets/images/sample.jpg')
      shop_image.attach(io: File.open(file_path), filename: 'sample.jpg', content_type: 'image/jpeg')
    end
    shop_image.variant(resize_to_limit: [width, height]).processed
  end

  def favorite_shop_by?(member)
    favorite_shops.exists?(member_id: member.id)
  end

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
      shop.address = '○○県△△市□□町0-0'
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
end
