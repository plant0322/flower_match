require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'status_codeが正しい', spec_category: "ページが正常に読み込まれているか" do
        expect(page.status_code).to eq(200)
      end
    end
  end
end