// Entry point for the build script in your package.json.
import "@hotwired/turbo-rails"

// Stimulus controllers.
import "../controllers"

import Raty from "../raty.js"
window.raty = function(elem,opt) {
    let raty = new Raty(elem,opt)
    raty.init();
    return raty;
}