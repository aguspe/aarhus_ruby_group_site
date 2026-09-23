import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.timeout = setTimeout(() => {
      this.element.style.opacity = "0"
      this.element.style.transition = "opacity 0.3s"
      setTimeout(() => this.element.remove(), 300)
    }, 4000)
  }

  disconnect() {
    clearTimeout(this.timeout)
  }
}
