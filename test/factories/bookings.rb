FactoryBot.define do
  factory :booking do
    association :user
    association :hotel
    price { 100.0 }
    currency { "USD" }
    arrival_date { Date.today + 1 }
    departure_date { Date.today + 2 }
    guest_name { "Guest Name" }
    guest_email { "guest#{SecureRandom.hex(4)}@example.com" }
  end
end
