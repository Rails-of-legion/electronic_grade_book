import { Controller } from "@hotwired/stimulus";


export default class extends Controller {
 static targets = ["password"];


 togglePassword() {
   const passwordField = this.passwordTarget;
   if (passwordField.type === "password") {
     passwordField.type = "text";
   } else {
     passwordField.type = "password";
   }
 }
}

