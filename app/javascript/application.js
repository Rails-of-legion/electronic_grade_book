// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./controllers";
import * as bootstrap from "bootstrap"

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus"

const application = Application.start()
const context = require.context("controllers", true, /\.js$/)
application.load(definitionsFromContext(context))
