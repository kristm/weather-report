import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

export default class extends Controller {
  connect() {
  }

  select(event) {
    //post('/forecast', { body: data, responseKind: 'turbo-stream' });
    console.log(event.target.getAttribute('data-lat'));
  }
}
