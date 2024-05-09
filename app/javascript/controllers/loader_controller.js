import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const target = this.element;
    const config = { childList: true };
    const callback = (mutationList, observer) => {
      for (const mutation of mutationList) {
        if (mutation.type === "childList") {
          this.hide();
        } 
      }
    };

    const observer = new MutationObserver(callback);
    observer.observe(target, config);

    this.loaderAnim = document.querySelector("#loading");
  }

  hide() {
    this.loaderAnim.style.display = 'none';
  }
}
