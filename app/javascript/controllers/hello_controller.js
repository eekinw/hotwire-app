import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // declares a targer called name
  static targets = ["user"];

  connect() {
    console.log("Hello controller connected");
  }

  greet() {
    // this.<name>Target is the property created by Stimulus to access the target element.
    const name = this.userTarget.value;
    window.alert(`Hello, ${name}!`);
  }
}
