import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="paginate"
export default class extends Controller {
  static targets = ['nextPageLink']

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
}
