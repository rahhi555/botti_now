import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static values = {
    hasFlash: { type: Boolean, default: false }
  }

  connect() {
    if(!this.hasFlashValue) return

    this.element.classList.replace('opacity-0', 'opacity-1')
    setTimeout(() => {
      this.element.classList.replace('opacity-1', 'opacity-0')
      this.hasFlashValue = false
    }, 3000)
  }
}
