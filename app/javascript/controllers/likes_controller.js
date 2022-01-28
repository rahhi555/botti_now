import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="likes"
export default class extends Controller {
  submitLike() {
    this.element.querySelector('form')?.requestSubmit()
  }
}
