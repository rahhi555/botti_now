import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ['errorMessages']

  clearErrorMessages() {
    if(!this.hasErrorMessagesTarget) return

    this.errorMessagesTarget.parentNode.removeChild(this.errorMessagesTarget)
  }

  // APIから返答があるまで数秒あるので、その間フォームを無効にする
  disableFewSeconds(event) {
    this.element.reset()
    // エラーが返ってきた時はフォームを無効にしない
    if(!event.detail.success) return

    this.element.commit.disabled = true
    setTimeout(() => {
      this.element.commit.disabled = false
    }, 5000)
  }
}
