import { Controller } from "@hotwired/stimulus"
import {get} from "@rails/request.js"

export default class extends Controller {
  connect()
  {
    console.log("connected")
  }
  change(event){
    console.log(event.target.selectedOptions[0].value)
  }
}