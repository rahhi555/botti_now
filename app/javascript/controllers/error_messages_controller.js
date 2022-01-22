import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="error-messages"
export default class extends Controller {
  static targets = ['errorMessages']

  clearErrorMessages() {
    if(!this.hasErrorMessagesTarget) return

    const target = this.errorMessagesTarget
    const children = [...target.children]

    if(!children.length) return

    for(const child of children) {
      target.removeChild(child)
    }
  }
}
