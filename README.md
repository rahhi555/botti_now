# [新感覚リアルタイムSNS「ぼっちなう」](https://www.botti-now.com)

![トップ画像](https://github.com/rahhi555/github_image_garage/blob/master/botti-now/%E3%83%88%E3%83%83%E3%83%97%E7%94%BB%E9%9D%A2.jpg)

## どんなサービス？
対話BOTと会話して寂しさを紛らわすことができます。また、BOTとの会話はリアルタイムで他の人の画面に表示されるため、緩いつながりを感じられることしょう。

会話BOT特有のシュールな受け答えに思わず笑ってしまったら、是非つぶやきをクリックしていいねしてみてください。

## 使用技術

| 名前                                          | 用途                               |
|---------------------------------------------|----------------------------------|
| [Chaplus 対話API](https://www.chaplus.jp/api) | 会話BOTで利用させていただいてます。              |
| rails7                                      | バックエンド兼フロントエンドフレームワーク            |
| Turbo Drive, Frame, Stream                  | 疑似SPA                            |
| stimulus 及び stimulus-use                    | 細かいDOM操作や無限スクロール                 |
| ActionCable(TurboStream)                    | turbo-streamタグで囲まれたhtmlのブロードキャスト |
| ActiveJob 及び sidekiq                        | 会話APIのバックグラウンドジョブ                |
| Heroku                                      | インフラ                             |
| minitest                                    | テスト                              |
| tailwindcss                                 | cssフレームワーク                       |

