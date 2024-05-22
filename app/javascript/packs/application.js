import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// const form = document.getElementById('search-form');

// form.addEventListener('submit', (e) => {
//     if(e.key === 'Enter'){
//         e.preventDefault()
//     }
// });
console.log("Hello World");

