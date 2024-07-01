// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./controllers";
import * as bootstrap from "bootstrap"
import 'bootstrap/dist/js/bootstrap'
import "bootstrap/dist/css/bootstrap";
import 'bootstrap-icons/font/bootstrap-icons.css';

import { Button } from 'bootstrap';
import 'bootstrap/dist/js/bootstrap.bundle';

function scrollToTop() {
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

document.addEventListener("turbo:load", function() {
    var scrollToTopButton = document.getElementById('scrollToTopButton');

    window.addEventListener("scroll", function() {
        if (window.scrollY > 300) {
            scrollToTopButton.classList.remove('d-none');
        } else {
            scrollToTopButton.classList.add('d-none');
        }
    });

    scrollToTopButton.addEventListener("click", function() {
        scrollToTop();
    });
});

