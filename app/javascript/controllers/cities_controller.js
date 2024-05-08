import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from "@rails/request.js"

export default class extends Controller {
  connect() {
  }

  select(event) {
    console.log(event.target.getAttribute('data-lat'));
  }
}
