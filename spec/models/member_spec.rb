=begin

require 'rails_helper'

RSpec.describe "Memberモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { member.valid? }

    let!(:other_member) { create(:member) }
    let(:member) { build(:member) }

    context "last_name" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        member.last_name = ''
        is_expected.to eq false
      end
    end

    context "first_name" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        member.first_name = ''
        is_expected.to eq false
      end
    end

    context "last_name_kanaカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        member.last_name_kana = ''
        is_expected.to eq false
      end
      it "カタカナであること：英数文字列は×", spec_category: "バリデーションの確認" do
        member.last_name_kana = Faker::Lorem.characters(number: 10)
        is_expected.to eq false
      end
      it "カタカナであること：ひらがなは×", spec_category: "バリデーションの確認" do
        member.last_name_kana = Gimei.first.hiragana
        is_expected.to eq false
      end
      it "カタカナであること：漢字は×", spec_category: "バリデーションの確認" do
        member.last_name_kana = Gimei.first.kanji
        is_expected.to eq false
      end
    end

    context "first_name_kanaカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        member.first_name_kana = ''
        is_expected.to eq false
      end
      it "カタカナであること：英数文字列は×", spec_category: "バリデーションの確認" do
        member.first_name_kana = Faker::Lorem.characters(number: 10)
        is_expected.to eq false
      end
      it "カタカナであること：ひらがなは×", spec_category: "バリデーションの確認" do
        member.first_name_kana = Gimei.first.hiragana
        is_expected.to eq false
      end
      it "カタカナであること：漢字は×", spec_category: "バリデーションの確認" do
        member.first_name_kana = Gimei.first.kanji
        is_expected.to eq false
      end
    end

    context "nicknameカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        member.nickname = ''
        is_expected.to eq false
      end
    end

    context "postal_codeカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        member.postal_code = ''
        is_expected.to eq false
      end
      (1..6).each do |i|
        it "7文字以上の数字であること：#{i}文字の数字は×", spec_category: "バリデーションの確認" do
          member.postal_code = Faker::Number.leading_zero_number(digits: i)
          is_expected.to eq false
        end
      end
      it "7文字以上の数字であること：8文字の数字は×", spec_category: "バリデーションの確認" do
        member.postal_code = Faker::Number.leading_zero_number(digits: 8)
        is_expected.to eq false
      end
      it "7文字以上の数字であること：7文字の英字（例abcdefg）は×", spec_category: "バリデーションの確認" do
        member.postal_code = "abcdefg"
        is_expected.to eq false
      end
      it "7文字以上の数字であること：7文字の数字は〇", spec_category: "バリデーションの確認" do
        member.postal_code = Faker::Number.leading_zero_number(digits: 7)
        is_expected.to eq true
      end
    end

    context "addressカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        member.address = ''
        is_expected.to eq false
      end
    end

    context "telephone_numberカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        member.telephone_number = ''
        is_expected.to eq false
      end
      (1..9).each do |i|
        it "10～11文字以上の数字であること：#{i}文字の数字は×", spec_category: "バリデーションの確認" do
          member.telephone_number = Faker::Number.leading_zero_number(digits: i)
          is_expected.to eq false
        end
      end
      it "10～11文字以上の数字であること：12文字の数字は×", spec_category: "バリデーションの確認" do
        member.telephone_number = Faker::Number.leading_zero_number(digits: 12)
        is_expected.to eq false
      end
      (10..11).each do |i|
        it "10～11文字以上の数字であること：#{i}文字の数字は〇", spec_category: "バリデーションの確認" do
          member.telephone_number = Faker::Number.leading_zero_number(digits: i)
          is_expected.to eq true
        end
      end
    end

    context "emailカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        member.email = ''
        is_expected.to eq false
      end
      it "一意性があること", spec_category: "バリデーションの確認" do
        member.email = other_member.email
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "PreOrderモデルとの関係" do
      it "PreOrderが複数（has_many）", spec_category: "アソシエーションの確認" do
        expect(Member.reflect_on_association(:pre_orders).macro).to eq :has_many
      end
    end

    context "Bookmarkモデルとの関係" do
      it "Bookmarkが複数（has_many）", spec_category: "アソシエーションの確認" do
        expect(Member.reflect_on_association(:bookmarks).macro).to eq :has_many
      end
    end

    context "FavoriteShopモデルとの関係" do
      it "FavoriteShopが複数（has_many）", spec_category: "アソシエーションの確認" do
        expect(Member.reflect_on_association(:favorite_shops).macro).to eq :has_many
      end
    end

    context "MemberMessageモデルとの関係" do
      it "MemberMessageが複数（has_many）", spec_category: "アソシエーションの確認" do
        expect(Member.reflect_on_association(:member_messages).macro).to eq :has_many
      end
    end

    context "Roomモデルとの関係" do
      it "Roomが複数（has_many）", spec_category: "アソシエーションの確認" do
        expect(Member.reflect_on_association(:rooms).macro).to eq :has_many
      end
    end
  end
end

=end