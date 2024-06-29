require 'rails_helper'

RSpec.describe "PickUpTagモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { pick_up_tag.valid? }

    let!(:tag) { create(:tag) }
    let(:pick_up_tag) { build(:pick_up_tag, tag_id: tag.id) }

    context "nameカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        pick_up_tag.name = ''
        is_expected.to eq false
      end
    end

    context "introductionカラム" do
      it "空欄でないこと", spec_category: "バリデーションの確認" do
        pick_up_tag.introduction = ''
        is_expected.to eq false
      end
    end

    context "in_orderカラム" do
      it "0～20以内の数字であること：21は×", spec_category: "バリデーションの確認" do
        pick_up_tag.in_order = 21
        is_expected.to eq false
      end
      (0..20).each do |i|
        it "0～20以内の数字であること：#{i}は〇", spec_category: "バリデーションの確認" do
          pick_up_tag.in_order = i
          is_expected.to eq true
        end
      end
    end
  end
end