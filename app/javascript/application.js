// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap
//= require_tree .
// app/javascript/packs/application.js

document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.clickable-row').forEach(row => {
        row.addEventListener('click', () => {
            window.location.href = row.getAttribute('data-href');
        });
    });
});
jQuery(document).ready(function($) {
    import $ from 'jquery';
    window.$ = $; // Make jQuery available globally
    window.jQuery = $; // For compatibility with plugins that expect jQuery to be globally available
    import 'bootstrap';

    // Your code that uses $ (which is an alias for jQuery)
});