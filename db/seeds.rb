# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者
Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
  admin.email = ENV['ADMIN_EMAIL']
  admin.password = ENV['ADMIN_PASSWORD']
end

# 一般ユーザー
Member.find_or_create_by!(email: "hara@h") do |member|
  member.last_name = "原"
  member.first_name = "由香子"
  member.last_name_kana = "ハラ"
  member.first_name_kana = "ユカコ"
  member.nickname = "きつね"
  member.email = "hara@h"
  member.postal_code = "2345678"
  member.address = "兵庫県姫路市4-28"
  member.telephone_number = "11122223333"
  member.is_active = true
  member.password = "hhhhhh"
end

Member.find_or_create_by!(email: "koya@k") do |member|
  member.last_name = "小山"
  member.first_name = "睦美"
  member.last_name_kana = "コヤマ"
  member.first_name_kana = "ムツミ"
  member.nickname = "つきみ"
  member.email = "koya@k"
  member.postal_code = "3456789"
  member.address = "京都府京都市9-30"
  member.telephone_number = "44455556666"
  member.is_active = true
  member.password = "kkkkkk"
end

Member.find_or_create_by!(email: "nomu@n") do |member|
  member.last_name = "野村"
  member.first_name = "遠野"
  member.last_name_kana = "ノムラ"
  member.first_name_kana = "トオノ"
  member.nickname = "雨宿り"
  member.email = "nomu@n"
  member.postal_code = "9876543"
  member.address = "福島県福島市20-01"
  member.telephone_number = "7777889999"
  member.is_active = true
  member.password = "nnnnnn"
end

# ショップユーザー
howell = Shop.find_or_create_by!(email: "sasaki@s") do |shop|
  shop.name = "flowerShop HOWELL"
  shop.name_kana = "フラワーショップハウエル"
  shop.introduction = "ガーデニングにもおすすめのマーガレットもたくさん取り扱っています。"
  shop.representative_name = "佐々木 春菊"
  shop.postal_code = "1234567"
  shop.prefecture_code = "37"
  shop.address = "三豊市0-0"
  shop.opening_hour = "火～金10:00～18:00 土日11:00～17:00"
  shop.holiday = "月曜日"
  shop.parking = "駐車場あり（3台分）"
  shop.note = "ご相談も承ります。お気軽にお声掛けください。"
  shop.payment_method = "Visa／Mastercard／JCB／American Express／Diners Club／PayPay"
  shop.direction = "交差点の角の白い屋根が目印です"
  shop.telephone_number = "00088889999"
  shop.email = "sasaki@s"
  shop.is_active = true
  shop.password = "ssssss"
  shop.shop_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop1.jpg"), filename: "shop1.jpg")
end

botanya = Shop.find_or_create_by!(email: "haya@h") do |shop|
  shop.name = "牡丹屋"
  shop.name_kana = "ボタンヤ"
  shop.introduction = "アレンジはもちろん、寄せ植えのご依頼も承ります。"
  shop.representative_name = "葉山 紫"
  shop.postal_code = "1112233"
  shop.prefecture_code = "28"
  shop.address = "神戸市6-6"
  shop.opening_hour = "10:00～19:30"
  shop.holiday = "不定休"
  shop.parking = "駐車場あり"
  shop.note = "配送のご依頼もお受けしています。"
  shop.payment_method = "Visa／Mastercard／JCB／American Express／Diners Club"
  shop.direction = "ショッピングモール1F、西入口からお入りいただいて右手に店舗がございます"
  shop.telephone_number = "66677778888"
  shop.email = "haya@h"
  shop.is_active = true
  shop.password = "hhhhhh"
  shop.shop_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop2.jpg"), filename: "shop2.jpg")
end

als = Shop.find_or_create_by!(email: "yuri@y") do |shop|
  shop.name = "花屋 あるす"
  shop.name_kana = "ハナヤアルス"
  shop.introduction = "花束のアレンジが得意です。いろんなラッピングをご用意しているので、ご希望ありましたらご連絡ください。"
  shop.representative_name = "由利 水仙"
  shop.postal_code = "3334444"
  shop.prefecture_code = "20"
  shop.address = "長野市9-9"
  shop.opening_hour = "9:00～13:00 17:00～19:00"
  shop.holiday = "木曜日"
  shop.parking = "駐車場あり（2台分）"
  shop.note = "配送OK"
  shop.payment_method = "Visa／Mastercard／JCB／American Express／Diners Club／PayPay／Suica、manaca等交通系も決済可"
  shop.direction = "交差点の角の白い屋根が目印です"
  shop.telephone_number = "99966667777"
  shop.email = "yuri@y"
  shop.is_active = true
  shop.password = "yyyyyy"
  shop.shop_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop3.jpg"), filename: "shop3.jpg")
end

# タグ
Tag.find_or_create_by!(name: "花束")

Tag.find_or_create_by!(name: "フラワーアレンジ")

Tag.find_or_create_by!(name: "花籠")

Tag.find_or_create_by!(name: "日常のお花")

Tag.find_or_create_by!(name: "大きな花束")

Tag.find_or_create_by!(name: "母の日")

Tag.find_or_create_by!(name: "プレゼント")

Tag.find_or_create_by!(name: "お祝い")

Tag.find_or_create_by!(name: "誕生日")

Tag.find_or_create_by!(name: "プランター")

Tag.find_or_create_by!(name: "イベント")

Tag.find_or_create_by!(name: "小さな観葉植物")

Tag.find_or_create_by!(name: "一輪挿し")

Tag.find_or_create_by!(name: "花瓶")

# ショップhowellの商品1
Item.find_or_create_by!(name: "特別な記念日に贈る花束/ブーケ（大）") do |item|
  item.introduction ="特別な日のプレゼントにもおすすめの大きな花束です。"
  item.size = "幅30×高さ40×奥行き30㎝"
  item.price = "3000"
  item.stock = "10"
  item.deadline = "1"
  item.is_active = true
  item.first_is_active = true
  item.shop = howell
  item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop1-item1-1.jpg"), filename: "shop1-item1-1.jpg")

  tag_names = ['花束', '大きな花束', 'お祝い']
  tag_names.each do |name|
    tag = Tag.find_or_create_by!(name: name)
    ItemTag.find_or_create_by!(item: item, tag: tag)
  end
end

item = Item.find_by(name: "特別な記念日に贈る花束/ブーケ（大）")
ItemCheck.find_or_create_by!(item_id: item.id) do |item_check|
  item_check.label_check = true
  item_check.permission = "permit"
end

for i in 1..2 do
  ItemDetail.find_or_create_by!(item: item, in_order: "1#{i+1}") do |item_detail|
    item_detail.introduction = "鮮やかなダリアをアクセントに取り入れて、特別な日を彩ります。ラッピングにリボンをお付けすることもできるので、お気軽にご相談ください。"
    item_detail.item_detail_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop1-item1-#{i+1}.jpg"), filename: "shop1-item1-#{i+1}.jpg")
  end
end

# ショップhowellの商品2
Item.find_or_create_by!(name: "ドーム型の花束づくり/アレンジ体験") do |item|
  item.introduction ="どの角度から見ても可愛い真ん丸の花束を、一緒に作成する体験イベントです。\nスタッフが1から説明しながら作成するので、気軽におしゃべりしながら楽しんで参加したい方をお待ちしています。\n※イベントは毎週水曜日の10時から行っています。予約時の日時指定にご注意ください。"
  item.size = "幅30×高さ40×奥行き40㎝"
  item.price = "5000"
  item.stock = "5"
  item.deadline = "7"
  item.is_active = true
  item.first_is_active = true
  item.shop = howell
  item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop1-item2-1.jpg"), filename: "shop1-item2-1.jpg")

  tag_names = ['花束', '大きな花束', 'フラワーアレンジ', 'イベント']
  tag_names.each do |name|
    tag = Tag.find_or_create_by!(name: name)
    ItemTag.find_or_create_by!(item: item, tag: tag)
  end
end

item = Item.find_by(name: "ドーム型の花束づくり/アレンジ体験")
ItemCheck.find_or_create_by!(item_id: item.id) do |item_check|
  item_check.label_check = true
  item_check.permission = "permit"
end

for i in 1..2 do
  ItemDetail.find_or_create_by!(item: item, in_order: "1#{i+1}") do |item_detail|
    item_detail.introduction = "いろいろあるお花の中からお好きなものを選んで作成いただけます。\n必要な道具なども全てこちらでご用意しています。"
    item_detail.item_detail_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop1-item2-#{i+1}.jpg"), filename: "shop1-item2-#{i+1}.jpg")
  end
end

# ショップhowellの商品3
Item.find_or_create_by!(name: "母の日のフラワーアレンジ/メッセージカード付") do |item|
  item.introduction ="母の日の贈り物にいかがでしょう？"
  item.size = "幅30×高さ40×奥行き30㎝"
  item.price = "3000"
  item.stock = "10"
  item.deadline = "3"
  item.is_active = true
  item.first_is_active = true
  item.shop = howell
  item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop1-item3-1.jpg"), filename: "shop1-item3-1.jpg")

  tag_names = ['母の日', 'プレゼント', 'フラワーアレンジ']
  tag_names.each do |name|
    tag = Tag.find_or_create_by!(name: name)
    ItemTag.find_or_create_by!(item: item, tag: tag)
  end
end

item = Item.find_by(name: "母の日のフラワーアレンジ/メッセージカード付")
ItemCheck.find_or_create_by!(item_id: item.id) do |item_check|
  item_check.label_check = true
  item_check.permission = "permit"
end

for i in 1..2 do
  ItemDetail.find_or_create_by!(item: item, in_order: "1#{i+1}") do |item_detail|
    item_detail.introduction = "春の花を使った母の日のフラワーアレンジです。メッセージカードも一緒にお付けします。"
    item_detail.item_detail_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop1-item3-#{i+1}.jpg"), filename: "shop1-item3-#{i+1}.jpg")
  end
end

# ショップhowellの商品4
for i in 1..2 do
  Item.find_or_create_by!(name: "あじさいセット#{i+1}" ) do |item|
    item.introduction ="1つだけで目を惹く紫陽花を飾って、気軽にお花のある暮らしを楽しんでみましょう。"
    item.size = "幅15×高さ30×奥行き15㎝"
    item.price = "#{i*500}"
    item.stock = "#{i*5}"
    item.deadline = "1"
    item.is_active = true
    item.first_is_active = true
    item.shop = howell
    item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop1-item4-1.jpg"), filename: "shop1-item4-1.jpg")

    tag_names = ['一輪挿し', '日常のお花', '花瓶']
    tag_names.each do |name|
      tag = Tag.find_or_create_by!(name: name)
      ItemTag.find_or_create_by!(item: item, tag: tag)
    end
  end

  item = Item.find_by(name: "あじさいセット#{i+1}")
  ItemCheck.find_or_create_by!(item_id: item.id) do |item_check|
    item_check.label_check = true
    item_check.permission = "permit"
  end

  for i in 1..2 do
    ItemDetail.find_or_create_by!(item: item, in_order: "1#{i+1}") do |item_detail|
      item_detail.introduction = "季節を感じる紫陽花です。一輪挿しとして飾っても映えます。"
      item_detail.item_detail_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop1-item4-#{i+1}.jpg"), filename: "shop1-item4-#{i+1}.jpg")
    end
  end
end

# ショップbotanyaの商品1
for i in 1..2 do
  Item.find_or_create_by!(name: "寄せ植え体験#{i+1}" ) do |item|
    item.introduction ="簡単な寄せ植えを一緒に作ってみましょう。所要時間1時間。"
    item.size = "幅15×高さ20×奥行き15㎝"
    item.price = "#{i*1000}"
    item.stock = "#{i*3}"
    item.deadline = "4"
    item.is_active = true
    item.first_is_active = true
    item.shop = botanya
    item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop2-item1-1.jpg"), filename: "shop2-item1-1.jpg")

    tag_names = ['プランター', 'イベント', '小さな観葉植物']
    tag_names.each do |name|
      tag = Tag.find_or_create_by!(name: name)
      ItemTag.find_or_create_by!(item: item, tag: tag)
    end
  end

  item = Item.find_by(name: "寄せ植え体験#{i+1}")
  ItemCheck.find_or_create_by!(item_id: item.id) do |item_check|
    item_check.label_check = true
    item_check.permission = "permit"
  end

  for i in 1..2 do
    ItemDetail.find_or_create_by!(item: item, in_order: "1#{i+1}") do |item_detail|
      item_detail.introduction = "お花の寄せ植え体験です。日曜日のAM9:00から行っています。必要な道具は揃っていますので手ぶらでご来店ください。"
      item_detail.item_detail_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop2-item1-#{i+1}.jpg"), filename: "shop2-item1-#{i+1}.jpg")
    end
  end
end

# ショップbotanyaの商品2
for i in 1..3 do
  Item.find_or_create_by!(name: "ミニサボテン入荷#{i+1}") do |item|
    item.introduction ="可愛いサボテンが入荷しました。個性豊かないろんな子が揃っています。\n来店いただいた方に先着順で販売致しますので、ご希望の鉢がある方は早めの日程でご予約ください。"
    item.size = "約幅10×高さ15×奥行き10㎝"
    item.price = "#{i*500}"
    item.stock = "#{i*4}"
    item.deadline = "1"
    item.is_active = true
    item.first_is_active = true
    item.shop = botanya
    item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop2-item2-1.jpg"), filename: "shop2-item2-1.jpg")

    tag_names = ['プランター', 'イベント', '小さな観葉植物']
    tag_names.each do |name|
      tag = Tag.find_or_create_by!(name: name)
      ItemTag.find_or_create_by!(item: item, tag: tag)
    end
  end

  item = Item.find_by(name: "ミニサボテン入荷#{i+1}")
  ItemCheck.find_or_create_by!(item_id: item.id) do |item_check|
    item_check.label_check = true
    item_check.permission = "permit"
  end

  ItemDetail.find_or_create_by!(item: item, in_order: "1") do |item_detail|
    item_detail.introduction = "鉢のデザインもそれぞれ異なります。鉢の植え替えはできませんのでご了承ください。"
    item_detail.item_detail_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop2-item2-2.jpg"), filename: "shop2-item2-2.jpg")
  end
end

# ショップalsの商品1
for i in 1..3 do
  Item.find_or_create_by!(name: "可愛いミニバラを使った上品な雰囲気の花束（贈り物にオススメのブーケ）#{i+1}") do |item|
    item.introduction ="上品なミニ薔薇がたくさん入荷しました。\n大人な雰囲気が可愛い薔薇の花束で、日ごろの感謝の気持ちを伝えてみませんか？\n\nピンク以外にも、イエロー、オレンジ、ホワイトなどのカラーが揃っています。"
    item.size = "幅30×高さ40×奥行き30㎝"
    item.price = "#{i*2000}"
    item.stock = "#{i*10}"
    item.deadline = "1"
    item.is_active = true
    item.first_is_active = true
    item.shop = als
    item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop3-item1-1.jpg"), filename: "shop3-item1-1.jpg")

    tag_names = ['花束', '大きな花束', 'お祝い', '誕生日', 'プレゼント']
    tag_names.each do |name|
      tag = Tag.find_or_create_by!(name: name)
      ItemTag.find_or_create_by!(item: item, tag: tag)
    end
  end

  item = Item.find_by(name: "可愛いミニバラを使った上品な雰囲気の花束（贈り物にオススメのブーケ）#{i+1}")
  ItemCheck.find_or_create_by!(item_id: item.id) do |item_check|
    item_check.label_check = true
    item_check.permission = "permit"
  end

  for i in 1..2 do
    ItemDetail.find_or_create_by!(item: item, in_order: "1#{i+1}") do |item_detail|
      item_detail.introduction = "バラをたっぷり使った花束です。カラーも複数ご用意してあるので、ご希望の色がありましたらご要望欄からご連絡ください。色によっては在庫切れの場合もありますので、予めメールやメッセージなどからお問い合わせいただければ、在庫状況をお知らせすることも可能です。"
      item_detail.item_detail_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop3-item1-#{i+1}.jpg"), filename: "shop3-item1-#{i+1}.jpg")
    end
  end
end

# ショップalsの商品2
for i in 1..3 do
  Item.find_or_create_by!(name: "母の日に贈るアンティーク調の落ち着いた色合いがおしゃれなブーケ（可愛い花束）#{i+1}") do |item|
    item.introduction ="いつもと一味違う大人な雰囲気の漂う、アンティークカラーが可愛いカーネーションを使った花束。\nお花のかわいらしさが際立つように、ラッピングはホワイトカラーで上品に仕上げています。\n\n今年は、しっとりと楽しむ大人な母の日をプレゼントしてみませんか？"
    item.size = "幅40×高さ50×奥行き40㎝"
    item.price = "#{i*2500}"
    item.stock = "#{i*10}"
    item.deadline = "5"
    item.is_active = true
    item.first_is_active = true
    item.shop = als
    item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop3-item2-1.jpg"), filename: "shop3-item2-1.jpg")

    tag_names = ['花束', '大きな花束', 'お祝い', '母の日']
    tag_names.each do |name|
      tag = Tag.find_or_create_by!(name: name)
      ItemTag.find_or_create_by!(item: item, tag: tag)
    end
  end

  item = Item.find_by(name: "母の日に贈るアンティーク調の落ち着いた色合いがおしゃれなブーケ（可愛い花束）#{i+1}")
  ItemCheck.find_or_create_by!(item_id: item.id) do |item_check|
    item_check.label_check = true
    item_check.permission = "permit"
  end

  ItemDetail.find_or_create_by!(item: item, in_order: "1") do |item_detail|
    item_detail.introduction = "ホワイトをベースにしたアンティーク調のアレンジです。上品な花束になっているので、母の日や大人の雰囲気を楽しみたい方にもおすすめ。"
    item_detail.item_detail_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop3-item2-2.jpg"), filename: "shop3-item2-2.jpg")
  end
end

# ショップalsの商品3
for i in 1..2 do
  Item.find_or_create_by!(name: "胡蝶蘭やバラを使った高級感のあるフラワーアレンジメント（お祝いのお花）#{i+1}") do |item|
    item.introduction ="特別な日に送るのにピッタリなフラワーアレンジメントです。\n高級感のある胡蝶蘭と赤いバラをアクセントに取り入れています。"
    item.size = "幅40×高さ50×奥行き40㎝"
    item.price = "#{i*6000}"
    item.stock = "#{i*10}"
    item.deadline = "2"
    item.is_active = true
    item.first_is_active = true
    item.shop = als
    item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop3-item3-1.jpg"), filename: "shop3-item3-1.jpg")

    tag_names = ['花籠', 'フラワーアレンジ', 'お祝い', 'プレゼント']
    tag_names.each do |name|
      tag = Tag.find_or_create_by!(name: name)
      ItemTag.find_or_create_by!(item: item, tag: tag)
    end
  end

  item = Item.find_by(name: "胡蝶蘭やバラを使った高級感のあるフラワーアレンジメント（お祝いのお花）#{i+1}")
  ItemCheck.find_or_create_by!(item_id: item.id) do |item_check|
    item_check.label_check = true
    item_check.permission = "permit"
  end

  ItemDetail.find_or_create_by!(item: item, in_order: "1") do |item_detail|
    item_detail.introduction = "ホワイトとレッドの組み合わせで華やかな雰囲気を醸し出すフラワーアレンジです。贈り物としても人気のアイテムなので、特別な日のお祝いにいかがでしょう？"
    item_detail.item_detail_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop3-item3-2.jpg"), filename: "shop3-item3-2.jpg")
  end
end

# ショップalsの商品4
for i in 1..2 do
  Item.find_or_create_by!(name: "大きなお花がパッと目を惹く日常のお花セット（一輪挿しにもおすすめ）#{i+1}") do |item|
    item.introduction ="1輪だけでも目を惹く大きなお花をセットにしてお渡しします。\n一輪挿しにも使いやすいので、まとめて飾るのはもちろん、一輪ずつ分けて生けるのもおすすめです。\n\n花瓶じゃなくても空き瓶などに生けても映えるので、お家でお気軽に取り入れてみてください。"
    item.size = "幅10×高さ50×奥行き10㎝"
    item.price = "#{i*3000}"
    item.stock = "#{i*4}"
    item.deadline = "2"
    item.is_active = true
    item.first_is_active = true
    item.shop = als
    item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop3-item4-1.jpg"), filename: "shop3-item4-1.jpg")

  tag_names = ['小さな観葉植物', '日常のお花', '一輪挿し']
  tag_names.each do |name|
    tag = Tag.find_or_create_by!(name: name)
    ItemTag.find_or_create_by!(item: item, tag: tag)
  end
  end

  item = Item.find_by(name: "大きなお花がパッと目を惹く日常のお花セット（一輪挿しにもおすすめ）#{i+1}")
  ItemCheck.find_or_create_by!(item_id: item.id) do |item_check|
    item_check.label_check = true
    item_check.permission = "permit"
  end

  for i in 1..2 do
    ItemDetail.find_or_create_by!(item: item, in_order: "1#{i+1}") do |item_detail|
      item_detail.introduction = "すらりと伸びた姿が美しいお花をセットにしました。大きく開いたお花がお部屋の空間を彩ってくれるので、いつものお部屋もパッと明るい雰囲気に。"
      item_detail.item_detail_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop3-item4-#{i+1}.jpg"), filename: "shop3-item4-#{i+1}.jpg")
    end
  end
end