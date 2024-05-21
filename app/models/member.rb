class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :pre_orders, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :favorite_shops, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :nickname, presence: true
  validates :email, presence: true
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :telephone_number, presence: true, uniqueness: true, format: { with: /\A\d{10,11}\z/ }

  def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/sample.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def member_full_name
    last_name + ' ' + first_name
  end

  def member_full_name_kana
    last_name_kana + ' ' + first_name_kana
  end

  # ゲストログイン用
  GUEST_MEMBER_EMAIL = 'guest_member@example.com'

  def self.guest
    find_or_create_by!(email: GUEST_MEMBER_EMAIL) do |member|
      member.password = SecureRandom.urlsafe_base64
      member.last_name = 'お試し'
      member.first_name = '花実'
      member.last_name_kana = 'オタメシ'
      member.first_name_kana = 'ハナミ'
      member.nickname = 'おたみ'
      member.postal_code = '0000000'
      member.address = '○○県△△市□□町0-0'
      member.telephone_number = '11111111111'
      member.is_active = 'true'
    end
  end
end
