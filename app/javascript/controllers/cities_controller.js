import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

export default class extends Controller {
  connect() {
  }

  select(event) {
    event.preventDefault();

    const label = this.element.previousElementSibling.querySelector('.dropdown-label');
    label.textContent = event.target.textContent;
    
    const coords = {};
    coords['lat'] = event.target.getAttribute('data-lat');
    coords['long'] = event.target.getAttribute('data-long');

    const data = {coords: coords};
    post('/forecast', { body: data, responseKind: 'turbo-stream' });
  }
}
