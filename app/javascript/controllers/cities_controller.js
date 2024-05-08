import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
  }

  select(event) {
    console.log(event.target.getAttribute('data-lat'));
  }
}
