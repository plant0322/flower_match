require 'rails_helper'

RSpec.describe 'itemモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { item.valid? }
    
    let(:shop) { create(:shop) }
    let!(:item) { build(:item, shop_id: shop.id) }
    
    context 'nameカラム' do
      it '空でないこと', spec_category: 'バリデーションとメッセージ表示' do
        item.name = ''
        is_expected.to eq false
      end
    end
  end
end