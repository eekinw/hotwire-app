import { Controller } from "@hotwired/stimulus";
import confetti from "canvas-confetti";

export default class extends Controller {
  // static targets = ["button"];

  connect() {
    console.log("Controller connected");
  }

  launchConfetti() {
    console.log("Launching confetti!");
    confetti({
      particleCount: 150,
      spread: 120,
      origin: { x: 0.5, y: 0.5 },
    });
  }
}
