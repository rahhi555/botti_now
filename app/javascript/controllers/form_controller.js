import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ['errorMessages']

  clearErrorMessages() {
    if(!this.hasErrorMessagesTarget) return

    this.errorMessagesTarget.parentNode.removeChild(this.errorMessagesTarget)
  }

  clearForm() {
    this.element.reset()
  }
}
