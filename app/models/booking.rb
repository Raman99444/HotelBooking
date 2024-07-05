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

  validates :hotel_name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :currency, presence: true
  validates :arrival_date, presence: true
  validates :departure_date, presence: true
  validates :guest_name, presence: true
  validates :guest_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  validate :arrival_date_cannot_be_in_the_past
  validate :departure_date_cannot_be_before_arrival_date

  private

  def arrival_date_cannot_be_in_the_past
    if arrival_date.present? && arrival_date < Date.today
      errors.add(:arrival_date, "cannot be in the past")
    end
  end

  def departure_date_cannot_be_before_arrival_date
    if departure_date.present? && departure_date < arrival_date
      errors.add(:departure_date, "cannot be earlier than arrival date")
    end
  end
end
