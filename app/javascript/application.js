import { Controller } from "@hotwired/stimulus"
import { debounce } from "lodash"

export default class extends Controller {
  static targets = ["input", "results"]

  connect() {
    this.inputTarget.addEventListener("input", debounce(this.search.bind(this), 500))
  }

  async search() {
    const query = this.inputTarget.value.trim()

    if (query) {
      const response = await fetch(`/search?query=${query}`)
      const data = await response.json()

      this.resultsTarget.innerHTML = data.map(result => `<div>${result}</div>`).join('')
    }
  }
}
