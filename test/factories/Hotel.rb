FactoryBot.define do
  factory :hotel do
    name { "Test Hotel #{SecureRandom.hex(4)}" }
  end
end
