// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rail
import "@popperjs/core"
import "@hotwired/turbo-rails"
import * as bootstrap from 'bootstrap'
import "controllers"

document.documentElement.addEventListener('turbo:load', () => {
  const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
  const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
});
