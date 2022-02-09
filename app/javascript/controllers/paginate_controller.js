import { Controller } from "@hotwired/stimulus"
import { useIntersection } from 'stimulus-use'

// Connects to data-controller="paginate"
export default class extends Controller {
  static targets = ['nextPageLink', 'infiniteScroll']

  postRemoveSelf({ target }) {
    const parentNode = target.parentNode
    parentNode.removeChild(target)

    if(!parentNode.childElementCount) {
      this.nextPageFetch()
    }
  }

  nextPageFetch() {
    if (!this.hasNextPageLinkTarget) return
    
    this.nextPageLinkTarget.click()
  }

  infiniteScrollTargetConnected() {
    this.unobserve = useIntersection(this, { element: this.infiniteScrollTarget })[1]
  }

  appear() {
    this.unobserve()
    this.infiniteScrollTarget.removeAttribute('data-paginate-target')
    this.nextPageFetch()
  }
}
