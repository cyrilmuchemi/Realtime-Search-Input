import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["query"];

  async search(event) {
    if (event.key !== "Enter") return; // Only handle Enter key press

    event.preventDefault(); // Prevent default form submission

    const query = this.queryTarget.value.trim();

    if (query.length === 0) {
      this.resultsTarget.innerHTML = ""; // Handle empty query (optional)
      return;
    }

    try {
      // ... rest of your search logic here (fetch, display results/errors)
    } catch (error) {
      // ... error handling
    }
  }
}