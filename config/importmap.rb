# config/importmap.rb
pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "jquery", to: "https://code.jquery.com/jquery-3.7.1.min.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
