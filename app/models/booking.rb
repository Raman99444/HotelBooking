class Booking
  include Mongoid::Document
  include Mongoid::Timestamps
  field :hotel_name, type: String
  field :price, type: Float
  field :currency, type: String
  field :arrival_date, type: Date
  field :departure_date, type: Date
  field :guest_name, type: String
  field :guest_email, type: String

  belongs_to :user
end
