module MetaTagsHelper
  def default_meta_tags
    {
      site: 'ぼっちなう',
      title: '新感覚リアルタイムSNS「ぼっちなう」',
      reverse: true,
      charset: 'utf-8',
      description: '会話BOTとのおしゃべりがリアルタイムに共有できる!「緩いつながり」を感じることのできる新感覚SNS!',
      keywords: '会話BOT,Rails7,HotWire,rails-turbo',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('logo.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      ],
      og: {
        site_name: 'ぼっちなう',
        title: 'ぼっちなう',
        description: '会話BOTとのおしゃべりがリアルタイムに共有できる!「緩いつながり」を感じることのできる新感覚SNS!',
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary',
        site: '@6MvpqmS7ThQbuBc',
      }
    }
  end
end