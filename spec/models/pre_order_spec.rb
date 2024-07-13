require 'rails_helper'

RSpec.describe "PreOrderのテスト" do
  describe "バリデーションのテスト" do
    subject { pre_order.valid? }

    let(:member) { create(:member) }
    let(:shop) { create(:shop) }
    let(:item) { create(:item, shop_id: shop.id) }
    let!(:pre_order) { create(:pre_order, item_id: item.id, member_id: member.id) }

    context "amountカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        pre_order.amount = ''
        is_expected.to eq false
      end
    end

    context "visit_dayカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        pre_order.visit_day = ''
        is_expected.to eq false
      end
    end

    context "visit_timeカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        pre_order.visit_time = ''
        is_expected.to eq false
      end
    end

    context "purposeカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        pre_order.purpose = ''
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Memberモデルとの関係" do
      it "Memberが1つ（belongs_to）", spec_category: "アソシエーションの確認" do
        expect(PreOrder.reflect_on_association(:member).macro).to eq :belongs_to
      end
    end

    context "Itemモデルとの関係" do
      it "Itemが1つ（belongs_to）", spec_category: "アソシエーションの確認" do
        expect(PreOrder.reflect_on_association(:item).macro).to eq :belongs_to
      end
    end

    context "Reviewモデルとの関係" do
      it "Reviewが1つ（belongs_to）", spec_category: "アソシエーションの確認" do
        expect(PreOrder.reflect_on_association(:review).macro).to eq :has_one
      end
    end
  end
end