=begin

require 'rails_helper'

RSpec.describe "Shopモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { shop.valid? }

    let!(:other_shop) { create(:shop) }
    let(:shop) { create(:shop) }

    context "nameカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        shop.name = ''
        is_expected.to eq false
      end
    end

    context "name_kanaカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        shop.name_kana = ''
        is_expected.to eq false
      end
      it "カタカナであること：英数文字列は×", spec_category: "バリデーションの確認" do
        shop.name_kana = Faker::Lorem.characters(number: 10)
        is_expected.to eq false
      end
      it "カタカナであること：ひらがなは×", spec_category: "バリデーションの確認" do
        shop.name_kana = Gimei.first.hiragana
        is_expected.to eq false
      end
      it "カタカナであること：漢字は×", spec_category: "バリデーションの確認" do
        shop.name_kana = Gimei.first.kanji
        is_expected.to eq false
      end
    end

    context "introductionカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        shop.introduction = ''
        is_expected.to eq false
      end
    end

    context "representative_nameカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        shop.representative_name = ''
        is_expected.to eq false
      end
    end

    context "postal_codeカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        shop.postal_code = ''
        is_expected.to eq false
      end
      (1..6).each do |i|
        it "7文字以上の数字であること：#{i}文字の数字は×", spec_category: "バリデーションの確認" do
          shop.postal_code = Faker::Number.leading_zero_number(digits: i)
          is_expected.to eq false
        end
      end
      it "7文字以上の数字であること：8文字の数字は×", spec_category: "バリデーションの確認" do
        shop.postal_code = Faker::Number.leading_zero_number(digits: 8)
        is_expected.to eq false
      end
      it "7文字以上の数字であること：7文字の英字（例abcdefg）は×", spec_category: "バリデーションの確認" do
        shop.postal_code = "abcdefg"
        is_expected.to eq false
      end
      it "7文字以上の数字であること：7文字の数字は〇", spec_category: "バリデーションの確認" do
        shop.postal_code = Faker::Number.leading_zero_number(digits: 7)
        is_expected.to eq true
      end
    end

    context "prefecture_codeカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        shop.prefecture_code = ''
        is_expected.to eq false
      end
    end

    context "addressカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        shop.address = ''
        is_expected.to eq false
      end
    end

    context "opening_hourカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        shop.opening_hour = ''
        is_expected.to eq false
      end
    end

    context "holidayカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        shop.holiday = ''
        is_expected.to eq false
      end
    end

    context "parkingカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        shop.parking = ''
        is_expected.to eq false
      end
    end

    context "noteカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        shop.note = ''
        is_expected.to eq false
      end
    end

    context "payment_methodカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        shop.payment_method = ''
        is_expected.to eq false
      end
    end

    context "directionカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        shop.direction = ''
        is_expected.to eq false
      end
    end

    context "telephone_numberカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        shop.telephone_number = ''
        is_expected.to eq false
      end
      (1..9).each do |i|
        it "10～11文字以上の数字であること：#{i}文字の数字は×", spec_category: "バリデーションの確認" do
          shop.telephone_number = Faker::Number.leading_zero_number(digits: i)
          is_expected.to eq false
        end
      end
      it "10～11文字以上の数字であること：12文字の数字は×", spec_category: "バリデーションの確認" do
        shop.telephone_number = Faker::Number.leading_zero_number(digits: 12)
        is_expected.to eq false
      end
      (10..11).each do |i|
        it "10～11文字以上の数字であること：#{i}文字の数字は〇", spec_category: "バリデーションの確認" do
          shop.telephone_number = Faker::Number.leading_zero_number(digits: i)
          is_expected.to eq true
        end
      end
    end

    context "emailカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        shop.email = ''
        is_expected.to eq false
      end
      it "一意性があること", spec_category: "バリデーションの確認" do
        shop.email = other_shop.email
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Itemモデルとの関係" do
      it "Itemが複数（has_many）", spec_category: "アソシエーションの確認" do
        expect(Shop.reflect_on_association(:items).macro).to eq :has_many
      end
    end

    context "FavoriteShopモデルとの関係" do
      it "FavoriteShopが複数（has_many）", spec_category: "アソシエーションの確認" do
        expect(Shop.reflect_on_association(:favorite_shops).macro).to eq :has_many
      end
    end

    context "ShopMessageモデルとの関係" do
      it "ShopMessageが複数（has_many）", spec_category: "アソシエーションの確認" do
        expect(Shop.reflect_on_association(:shop_messages).macro).to eq :has_many
      end
    end

    context "Roomモデルとの関係" do
      it "Roomが複数（has_many）", spec_category: "アソシエーションの確認" do
        expect(Shop.reflect_on_association(:rooms).macro).to eq :has_many
      end
    end
  end
end

=end