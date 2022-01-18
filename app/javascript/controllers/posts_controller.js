import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="posts"
export default class extends Controller {
  removeSelf({ target }) {
    target.parentNode.removeChild(target)
  }
}
