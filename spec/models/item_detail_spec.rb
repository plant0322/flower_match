=begin

require 'rails_helper'

RSpec.describe "ItemDetailモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { item_detail.valid? }

    let!(:item) { create(:item) }
    let(:item_detail) { build(:item_detail, item_id: item.id) }

    context "introductionカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        item_detail.introduction = ''
        is_expected.to eq false
      end
    end

    context "in_orderカラム" do
      it "0～10以内の数字であること：11は×", spec_category: "バリデーションの確認" do
        item_detail.in_order = 11
        is_expected.to eq false
      end
      (0..10).each do |i|
        it "0～10以内の数字であること：#{i}は〇", spec_category: "バリデーションの確認" do
          item_detail.in_order = i
          is_expected.to eq true
        end
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Itemモデルとの関係" do
      it "Itemが1つ（belongs_to）", spec_category: "アソシエーションの確認" do
        expect(ItemDetail.reflect_on_association(:item).macro).to eq :belongs_to
      end
    end
  end
end

=end