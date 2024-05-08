import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

export default class extends Controller {
  connect() {
  }

  select(event) {
    const coords = {};
    coords['lat'] = event.target.getAttribute('data-lat');
    coords['long'] = event.target.getAttribute('data-long');
    const data = {coords: coords};
    post('/forecast', { body: data, responseKind: 'turbo-stream' });
    console.log(data, event.target.getAttribute('data-lat'));
  }
}
