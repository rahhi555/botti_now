# frozen_string_literal: true

module FlashHelper
  FLASH_ICON_PATH = {
    NOTICE: 'M20 3.33331C10.8 3.33331 3.33337 10.8 3.33337 20C3.33337 29.2 10.8 36.6666 20 36.6666C29.2 36.6666 36.6667
              29.2 36.6667 20C36.6667 10.8 29.2 3.33331 20 3.33331ZM16.6667 28.3333L8.33337 20L10.6834 17.65L16.6667
              23.6166L29.3167 10.9666L31.6667 13.3333L16.6667 28.3333Z',
    ALERT: 'M20 3.36667C10.8167 3.36667 3.3667 10.8167 3.3667 20C3.3667 29.1833 10.8167 36.6333 20 36.6333C29.1834 36.6333 36.6334 29.1833 36.6334 20C36.6334 10.8167 29.1834 3.36667 20 3.36667ZM19.1334 33.3333V22.9H13.3334L21.6667 6.66667V17.1H27.25L19.1334 33.3333Z'
  }.freeze

  # @return [Hash{ Symbol => String }]
  # flashのタイプに応じたハッシュを返す。
  # { bg: String, text: String, title: String, message: String, path: String }
  def flash_attributes
    case flash.keys
    in ['notice']
      { bg: 'bg-emerald-500', text: 'text-emerald-500', title: 'Success', message: flash.notice,
        path: FLASH_ICON_PATH[:NOTICE] }
    in ['alert']
      { bg: 'bg-red-500', text: 'text-red-500', title: 'Error', message: flash.alert, path: FLASH_ICON_PATH[:ALERT] }
    else
      { bg: '', text: '', title: '', message: '', path: '' }
    end
  end
end
