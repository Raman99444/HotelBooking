import Rails from "@rails/ujs"
import { Turbo } from "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import '../assets/javascripts/booking_validation'

Rails.start()
Turbo.start()
