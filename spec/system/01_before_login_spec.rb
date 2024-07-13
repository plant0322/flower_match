require 'rails_helper'

describe "[STEP1] ユーザログイン前のテスト" do
  let!(:shop) { create(:shop) }
  let!(:item) { create(:item, shop_id: shop.id, is_active: true) }
  let!(:item_check) { create(:item_check, item_id: item.id) }
  let!(:item_detail) { create(:item_detail, item_id: item.id) }
  let!(:tag) { create(:tag) }
  let!(:item_tag) { create(:item_tag, item_id: item.id, tag_id: tag.id) }

  describe "トップ画面のテスト" do
    before do
      visit root_path
    end

    context "トップ表示内容の確認" do
      it "status_codeが正しい", spec_category: "ページが正常に読み込まれているか" do
        expect(page.status_code).to eq(200)
      end
    end

    context "ヘッダーリンクの確認" do
      it "FlowerMatchのリンク", spec_dategory: "リンク先の設定" do
        expect(page).to have_link "FlowerMatch", href: "/"
      end
      it "商品一覧のリンク", spec_dategory: "リンク先の設定" do
        expect(page).to have_link "商品一覧", href: root_path
      end
      it "Aboutのリンク", spec_dategory: "リンク先の設定" do
        expect(page).to have_link "About", href: about_path
      end
      it "ログインのリンク", spec_dategory: "リンク先の設定" do
        expect(page).to have_link "ログイン", href: new_member_session_path
      end
    end

    context "ヘッダー検索機能の確認" do
      it "検索ボタンが表示されているか", spec_dategory: "検索機能の確認" do
        expect(page).to have_css('.fa-magnifying-glass')
      end
    end

    context "フッターリンクの確認" do
      it "ご利用ガイドのリンク", spec_dategory: "リンク先の設定" do
        expect(page).to have_link "ご利用ガイド", href: guide_path
      end
      it "ご利用規約のリンク", spec_dategory: "リンク先の設定" do
        expect(page).to have_link "ご利用規約", href: terms_path
      end
      it "プライバシーポリシーのリンク", spec_dategory: "リンク先の設定" do
        expect(page).to have_link "プライバシーポリシー", href: privacypolicy_path
      end
    end
  end

  describe "商品詳細画面のテスト" do
    before do
      visit item_path(item)
    end

    context "ショップ表示内容の確認" do
      it "status_codeが正しい", spec_category: "ページが正常に読み込まれているか" do
        expect(page.status_code).to eq(200)
      end
      it "ショップ名の表示", spec_category: "ショップ情報の表示" do
        expect(page).to have_content shop.name
      end
      it "ショップ郵便番号の表示", spec_category: "ショップ情報の表示" do
        expect(page).to have_content shop.postal_code.to_s.insert(3, "-")
      end
      it "ショップ住所の表示", spec_category: "ショップ情報の表示" do
        expect(page).to have_content shop.address
      end
      it "ショップ道案内の表示", spec_category: "ショップ情報の表示" do
        expect(page).to have_content shop.direction
      end
      it "ショップ画像の表示", spec_category: "ショップ情報の表示" do
        expect(page).to have_selector("img[src$='shop_image.jpg']")
      end
      it "ショップ詳細のリンク", spec_dategory: "リンク先の設定" do
        expect(page).to have_link "ショップ情報を見る", href: shop_path(shop)
      end
    end

    context "商品表示内容の確認" do
      it "商品名の表示", spec_category: "商品情報の表示" do
        expect(page).to have_content item.name
      end
      it "商品紹介の表示", spec_category: "商品情報の表示" do
        expect(page).to have_content item.introduction
      end
      it "商品金額の表示", spec_category: "商品情報の表示" do
        expect(page).to have_content item.price.to_s(:delimited, delimiter: ',')
      end
      it "商品サイズの表示", spec_category: "商品情報の表示" do
        expect(page).to have_content item.size
      end
      it "商品個数の表示", spec_category: "商品情報の表示" do
        expect(page).to have_content item.stock
      end
      it "商品キャンセル期限の表示", spec_category: "商品情報の表示" do
        expect(page).to have_content item.deadline
      end
      it "商品画像の表示", spec_category: "商品情報の表示" do
        expect(page).to have_selector("img[src$='item_image.jpg']")
      end
      it "商品詳細コメントの表示", spec_dategory: "商品情報の表示" do
        expect(page).to have_content item_detail.introduction
      end
      it "商品詳細画像の表示", spec_dategory: "商品情報の表示" do
        expect(page).to have_selector("img[src$='item_detail_image.jpg']")
      end
      it "予約のリンク", spec_dategory: "リンク先の設定" do
        expect(page).to have_link "ログインして予約する", href: new_member_session_path
      end
      it "タグのリンク", spec_dategory: "リンク先の設定" do
        expect(page).to have_link tag.name, href: "/search?model=tag&content=#{tag.name}"
      end
    end
  end
end