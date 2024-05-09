import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

export default class extends Controller {
  connect() {
    this.loaderAnim = document.querySelector("#loading");
    this.hideLoader();
  }

  showLoader() {
    this.loaderAnim.style.display = 'flex';
  }

  hideLoader() {
    this.loaderAnim.style.display = 'none';
  }

  select(event) {
    this.showLoader();
    event.preventDefault();

    const label = this.element.previousElementSibling.querySelector('.dropdown-label');
    label.textContent = event.target.textContent;
    
    const coords = {};
    coords['lat'] = event.target.getAttribute('data-lat');
    coords['long'] = event.target.getAttribute('data-long');

    post('/forecast', { body: {coords}, responseKind: 'turbo-stream' });
  }
}
