#require 'rails_helper'

#describe '商品投稿のテスト' do
#  let!(:item) { create(:item, name: 'name', introduction: 'introduction', price: '6000', size: 'size', stock: '10', deadline: '3') }
#  describe '詳細画面（show）のテスト' do
#    before do
#      visit item_path(item)
#    end
#    context '表示の確認' do
#      it 'item_path(item)が/items/:idになっているか' do
#        expect(current_path.to eq('/items/:id'))
#      end
#    end
#  end
#end