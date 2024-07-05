FactoryBot.define do
  factory :booking do
    association :user
    hotel_name { "Test Hotel" }
    price { 100.0 }
    currency { "USD" }
    arrival_date { Date.today + 1 }
    departure_date { Date.today + 2 }
    guest_name { "Guest Name" }
    guest_email { "guest@example.com" }
  end
end
