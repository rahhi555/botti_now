import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="posts"
export default class extends Controller {
  removeSelf({ target }) {
    target.parentNode.removeChild(target)
  }

  clearForm({ target }) {
    target.reset()
  }

  disableLikeButton({ currentTarget }) {
    const button = currentTarget.querySelector('button')
    button.classList.add('opacity-50','cursor-not-allowed')
    button.classList.remove('hover:bg-green-700')
    button.disabled = true
  }
}
