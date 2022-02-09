import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="posts"
export default class extends Controller {
  removeSelf({ target }) {
    target.parentNode.removeChild(target)

    if(!this.element.childElementCount) {
      const paginateLink = document.getElementById('paginate_link')
      paginateLink?.click()
    }
  }

  clearForm({ target }) {
    target.reset()
  }
}
