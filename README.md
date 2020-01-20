# Monochrogram
画像の投稿をコンセプトとしたInstagram風アプリです。

### URL
https://www.monochrogram-app.com/

- 画面下部の「簡単ログイン」からtestユーザーとしてログイン出来ます。

### 使用技術
- Ruby 2.6.3, Rails 5.2.3
- Nginx, Unicorn
- AWS (EC2, RDS for MySQL, VPC, Route53, ACM)
- SASS, Bootstrap, JQuery
- Rspec

### 機能概要
- Rspecによる自動テスト機能
- ユーザー登録・ログイン機能(devise)
- 画像投稿機能(CarrirWave)
- 投稿一覧・投稿詳細表示機能
- いいね機能(Ajax)
- コメント機能(Ajax)
