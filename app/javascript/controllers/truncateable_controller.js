import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        const max_elements = 50
        const element = this.element

        document.documentElement.addEventListener("turbo:before-stream-render", () => {
            if (element.children.length > max_elements) {
                for (let i = max_elements; i < element.children.length; i++) {
                    const removeElement = element.children[i]
                    removeElement.classList.add("slide-out-bottom")
                    setTimeout(function(){ removeElement.remove() }, 200)
                }
            }
        })
    }
}
