# 新感覚リアルタイムSNS「ぼっちなう」

![トップ画像](トップ画面.jpg)

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

