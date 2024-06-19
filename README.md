# 花屋まっちんぐ
​
## サイト概要
### サイトテーマ
お花屋さん発信型のフラワーアレンジメントや花束の予約サイト  

【TOPページ(一般ユーザーログイン後)】
![member](https://github.com/plant0322/flower_match/assets/159232279/0f09c467-9a13-465f-91c8-5f10ced0dacf)

【ショップユーザーマイページ(ショップログイン後)】
![shop](https://github.com/plant0322/flower_match/assets/159232279/a10f64e7-f483-46e0-9954-e3dbf9df27a8)

【管理者TOPページ(管理者ログイン後)】
![admin](https://github.com/plant0322/flower_match/assets/159232279/b50f0525-b00a-4e8c-afa1-7a91430b654d)

### テーマを選んだ理由
友人がお花屋さんで働いており、お花のアレンジメントや花束などを当日急に来店されたお客さまから注文されると、事前に準備することもできず焦ってしまって大変だという話を聞きました。  
また、私自身も友人から話を聞いたことで予約ができたけれど、他店だとどんな商品があってどのように購入すればいいか確認することが難しいと感じていました。  
花束などを購入した経験が少ない方には、さらに難しいのではないかと思います。

そこで、お花屋さん側が花束やアレンジメントを紹介して、お客さん側がそれを気軽に予約出来るサイトがあればこれらの問題を解決できると考え、このテーマを選びました。
​
### ターゲットユーザ
【お花屋さん】
- 商品やお花の入荷状況などを紹介したいお花屋さん
- 電話やメール以外の簡単な予約方法を取り入れたいお花屋さん

【買いたい人】
- 花束などの購入に慣れていない人
- 花束などを購入するお店を商品やお花の情報から探したい人
​
### 主な利用シーン
【お花屋さん】
- どんなアレンジが可能かなどの商品情報を発信したいとき
- 予約状況を確認をしたいとき

【買いたい人】
- お花のアレンジメントや花束の購入予約をしたいとき
- お花屋さんを探したいとき
​
### このサイトで出来ることや使い方
【お花屋さん】
1. 自分のショップ情報を登録する
2. 予約を受け付ける商品情報を登録する
3. 予約管理ページで予約状況を確認する
4. 予約者が来店して商品の受け渡しが完了したら予約状況を来店済みにする

【一般ユーザ】
1. 商品を選んで予約をする
2. 店舗で商品を受け取し料金の支払いをする
3. 予約状況が来店済みになったら口コミが投稿できる
4. 商品について質問したい場合などにメッセージから連絡が出来る

【管理者】
1. 季節のイベントとしてタグを設定できる
2. 投稿された商品の内容を確認して承認/承認不可設定、公開/非公開設定が出来る
3. 口コミの投稿内容を確認して公開/非公開設定が出来る
4. 一般ユーザ、ショップユーザの退会処理が出来る

## 設計書
【ER図】
![flower_match_ER](https://github.com/plant0322/flower_match/assets/159232279/aeb23804-3217-4859-9897-9eba393a823b)
​
## 使用技術

### Gem
- ユーザー認証(devise)
- 画像アップロード時のサイズと解像度の変更(MiniMagick)
- ショップ所在地の都道府県登録と検索(JpPrefecture)

### その他
- 画像アップロード機能(Active Storage)
- ブックマーク追加の非同期通信(Ajax)
- ショップお気に入り追加の非同期通信(Ajax)
- 商品画像の関連性判定(Google Vision API)
- 口コミのポジティブ判定(Google Natural Language API)

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
​
## 使用素材

- 商品画像：Canva
- アイコン：Font Awesome  
著作権を考慮し、架空のデータを扱う予定です。なお今後、実在するデータを利用する際には、事前に著作権保持者と契約を結んだ上で利用します。
