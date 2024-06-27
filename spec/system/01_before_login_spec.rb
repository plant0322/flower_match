require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end
    
    context '表示内容の確認' do
      it 'URLが正しい', spec_category: "ルーティング・URLの理解（ログイン状況に合わせた応用）" do
        expect(current_path).to eq '/'
      end
    end
  end
end