# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.find_or_create_by!(email: "admin@a") do |admin|
  admin.email = "admin@a"
  admin.password = "aaaaaa"
end

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

howell = Shop.find_or_create_by!(email: "sasaki@s") do |shop|
  shop.name = "flowerShop HOWELL"
  shop.name_kana = "フラワーショップハウエル"
  shop.introduction = "ガーデニングにもおすすめのマーガレットもたくさん取り扱っています。"
  shop.representative_name = "佐々木 春菊"
  shop.postal_code = "1234567"
  shop.address = "香川県三豊市0-0"
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
  shop.address = "兵庫県神戸市6-6"
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
  shop.address = "長野県長野市9-9"
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

Item.find_or_create_by!(name: "特別な記念日に贈る花束/ブーケ（大）") do |item|
  item.introduction ="特別な日のプレゼントにもおすすめの大きな花束です。"
  item.size = "幅30×高さ40×奥行き30㎝"
  item.price = "1500"
  item.stock = "10"
  item.deadline = "1"
  item.is_active = true
  item.shop = howell
  item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop1-item1-1.jpg"), filename: "shop1-item1-1.jpg")
end

Item.find_or_create_by!(name: "母の日のフラワーアレンジ/メッセージカード付") do |item|
  item.introduction ="母の日の贈り物にいかがでしょう？"
  item.size = "幅30×高さ40×奥行き30㎝"
  item.price = "3000"
  item.stock = "20"
  item.deadline = "3"
  item.is_active = true
  item.shop = howell
  item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop1-item2-1.jpg"), filename: "shop1-item2-1.jpg")
end

Item.find_or_create_by!(name: "寄せ植え体験") do |item|
  item.introduction ="簡単な寄せ植えを一緒に作ってみましょう。所要時間1時間。"
  item.size = "幅15×高さ20×奥行き15㎝"
  item.price = "4000"
  item.stock = "5"
  item.deadline = "4"
  item.is_active = true
  item.shop = botanya
  item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop2-item1-1.jpg"), filename: "shop2-item1-1.jpg")
end

Item.find_or_create_by!(name: "ミニサボテン入荷") do |item|
  item.introduction ="可愛いサボテンが入荷しました。個性豊かないろんな子が揃っています。来店いただいた方に先着順で販売致しますので、ご希望の鉢がある方は早めの日程でご予約ください。"
  item.size = "約幅10×高さ15×奥行き10㎝"
  item.price = "2000"
  item.stock = "20"
  item.deadline = "1"
  item.is_active = true
  item.shop = botanya
  item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop2-item2-1.jpg"), filename: "shop2-item2-1.jpg")
end

Item.find_or_create_by!(name: "大きなお花をたっぷり使った高級感のある華やかな花束（おしゃれなブーケ）") do |item|
  item.introduction ="ちょっと珍しいお花を使った華やかなブーケです。色とりどりの大きなお花をたっぷり使用しているので、お祝い事にもピッタリ。華やかなお花に合わせてラッピングにもこだわっています。ラッピングや取り入れたいお花の色など、ご希望がありましたらお気軽にご相談ください。"
  item.size = "幅40×高さ50×奥行き40㎝"
  item.price = "6500"
  item.stock = "10"
  item.deadline = "2"
  item.is_active = true
  item.shop = als
  item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop3-item1-1.jpg"), filename: "shop3-item1-1.jpg")
end

Item.find_or_create_by!(name: "可愛いミニバラを使った上品な雰囲気の花束（贈り物にオススメのブーケ）") do |item|
  item.introduction ="上品なミニ薔薇がたくさん入荷しました。大人な雰囲気のパステルカラーが可愛い薔薇の花束で、日ごろの感謝の気持ちを伝えてみませんか？ピンク以外にも、イエロー、オレンジ、ホワイトなどのカラーが揃っています。"
  item.size = "幅30×高さ40×奥行き30㎝"
  item.price = "3000"
  item.stock = "10"
  item.deadline = "1"
  item.is_active = true
  item.shop = als
  item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop3-item2-1.jpg"), filename: "shop3-item2-1.jpg")
end

Item.find_or_create_by!(name: "お任せブーケ。スタッフがお店のお花たちから厳選して作成する大きな花束") do |item|
  item.introduction ="入荷したばかりのお花たちの中から厳選して、スタッフが心を込めて花束を作成します。予約時のご要望欄にご希望の色やイメージなどをご記入いただければ、ご要望に合わせてあなただけの花束を作成しますので、お気軽にご記入ください。"
  item.size = "幅40×高さ50×奥行き40㎝"
  item.price = "5500"
  item.stock = "15"
  item.deadline = "2"
  item.is_active = true
  item.shop = als
  item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop3-item3-1.jpg"), filename: "shop3-item3-1.jpg")
end

Item.find_or_create_by!(name: "母の日に贈るアンティーク調の落ち着いた色合いがおしゃれなブーケ（可愛い花束）") do |item|
  item.introduction ="いつもと一味違う大人な雰囲気の漂う、アンティークカラーが可愛いカーネーションを使った花束。お花のかわいらしさが際立つように、ラッピングはホワイトカラーで上品に仕上げています。今年は、しっとりと楽しむ大人な母の日をプレゼントしてみませんか？"
  item.size = "幅40×高さ50×奥行き40㎝"
  item.price = "6700"
  item.stock = "20"
  item.deadline = "5"
  item.is_active = true
  item.shop = als
  item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop3-item4-1.jpg"), filename: "shop3-item4-1.jpg")
end