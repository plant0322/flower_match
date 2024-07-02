=begin

require 'rails_helper'

RSpec.describe "Itemモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { item.valid? }

    let!(:shop) { create(:shop) }
    let(:item) { build(:item, shop_id: shop.id) }

    context "nameカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        item.name = ''
        is_expected.to eq false
      end
    end

    context "introductionカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        item.introduction = ''
        is_expected.to eq false
      end
    end

    context "priceカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        item.price = ''
        is_expected.to eq false
      end
    end

    context "sizeカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        item.size = ''
        is_expected.to eq false
      end
    end

    context "stockカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        item.stock = ''
        is_expected.to eq false
      end
    end

    context "deadlineカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        item.deadline = ''
        is_expected.to eq false
      end
      it "20以内の数字であること:21は×", spec_category: "バリデーションの確認" do
        item.deadline = 21
        is_expected.to eq false
      end
      (0..20).each do |i|
        it "0～20以内の数字であること：#{i}は〇", spec_category: "バリデーションの確認" do
          item.deadline = i
          is_expected.to eq true
        end
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "PreOrderモデルとの関係" do
      it "PreOrderが複数（has_many）", spec_category: "アソシエーションの確認" do
        expect(Item.reflect_on_association(:pre_orders).macro).to eq :has_many
      end
    end

    context "Bookmarkモデルとの関係" do
      it "Bookmarkが複数（has_many）", spec_category: "アソシエーションの確認" do
        expect(Item.reflect_on_association(:bookmarks).macro).to eq :has_many
      end
    end

    context "ItemTagモデルとの関係" do
      it "ItemTagが複数（has_many）", spec_category: "アソシエーションの確認" do
        expect(Item.reflect_on_association(:item_tags).macro).to eq :has_many
      end
    end

    context "ItemDetailモデルとの関係" do
      it "ItemDetailが複数（has_many）", spec_category: "アソシエーションの確認" do
        expect(Item.reflect_on_association(:item_details).macro).to eq :has_many
      end
    end

    context "Tagモデルとの関係" do
      it "Tagが複数（has_many）", spec_category: "アソシエーションの確認" do
        expect(Item.reflect_on_association(:tags).macro).to eq :has_many
      end
    end

    context "Shopモデルとの関係" do
      it "Shopが1つ（belongs_to）", spec_category: "アソシエーションの確認" do
        expect(Item.reflect_on_association(:shop).macro).to eq :belongs_to
      end
    end

    context "ItemCheckモデルとの関係" do
      it "ItemCheckが1つ（has_one）", spec_category: "アソシエーションの確認" do
        expect(Item.reflect_on_association(:item_check).macro).to eq :has_one
      end
    end
  end
end

=end