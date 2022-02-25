import { Controller } from "@hotwired/stimulus"
import { useIntersection } from 'stimulus-use'

// Connects to data-controller="paginate"
export default class extends Controller {
  static targets = ['nextPageLink', 'infiniteScroll']

  // postsコントローラーのみのメソッド。アニメーションが終わったツイートを削除し、画面に表示されているツイートが少なければページネーションする
  postRemoveSelf({ target }) {
    const parentNode = target.parentNode
    parentNode.removeChild(target)

    if(parentNode.childElementCount < 4) {
      this.nextPageFetch()
    }
  }

  // ページネーションリンクをクリックして、続きのツイートをturbo_streamで取得する
  nextPageFetch() {
    if (!this.hasNextPageLinkTarget) return
    
    this.nextPageLinkTarget.click()
  }

  // 無限スクロール対象が存在する場合は、そのターゲットの監視を開始する。
  // また、後ほど監視を解除するため unobserve として保存する(useIntersectionの返り値は[0]がobserve,[1]がunobserve)
  infiniteScrollTargetConnected() {
    this.unobserve = useIntersection(this, { element: this.infiniteScrollTarget })[1]
  }

  // useIntersectionを使用した段階でappearコールバックメソッドが作成される。
  // 監視ターゲットにビューポートが入ったタイミングで発火する。
  appear() {
    this.unobserve()
    this.infiniteScrollTarget.removeAttribute('data-paginate-target')
    this.nextPageFetch()
  }
}
