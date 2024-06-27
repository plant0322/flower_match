require 'rails_helper'

RSpec.describe 'shopモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { shop.valid? }
    
    let(:shop) { create(:shop) }
    
    context 'nameカラム' do
      it '空でないこと', spec_category: 'バリデーションとメッセージ表示' do
        shop.name = ''
        is_expected.to eq false
      end
    end
  end
end