require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  def setup
    @user = User.create(
      email: "test@example.com",
      password: "password",
      name: "John Doe",
      birthday: Date.new(1990, 1, 1),
      gender: "Male",
      address: "123 Main St",
      pincode: "123456",
      state: "Test State"
    )
    @hotel = Hotel.create(name: "Test Hotel")
    @booking = @user.bookings.new(
      hotel: @hotel,
      price: 100.0,
      currency: "USD",
      arrival_date: Date.today + 1,
      departure_date: Date.today + 2,
      guest_name: "Guest Name",
      guest_email: "guest@example.com"
    )
  end

  test "should be valid with valid attributes" do
    assert @booking.valid?
  end

  test "should be invalid without a hotel_name" do
    @booking.hotel = nil
    assert_not @booking.valid?
  end

  test "should be invalid without a price" do
    @booking.price = nil
    assert_not @booking.valid?
  end

  test "should be invalid with a non-numeric price" do
    @booking.price = "not a number"
    assert_not @booking.valid?
  end

  test "should be invalid without a currency" do
    @booking.currency = ""
    assert_not @booking.valid?
  end

  test "should be invalid without an arrival_date" do
    @booking.arrival_date = nil
    assert_not @booking.valid?
  end

  test "should be invalid without a departure_date" do
    @booking.departure_date = nil
    assert_not @booking.valid?
  end

  test "should be invalid without a guest_name" do
    @booking.guest_name = ""
    assert_not @booking.valid?
  end

  test "should be invalid without a guest_email" do
    @booking.guest_email = ""
    assert_not @booking.valid?
  end

  test "should be invalid with a malformed guest_email" do
    @booking.guest_email = "not-an-email"
    assert_not @booking.valid?
  end

  test "should be invalid with arrival_date in the past" do
    @booking.arrival_date = Date.yesterday
    assert_not @booking.valid?
  end

  test "should be invalid with departure_date before arrival_date" do
    @booking.departure_date = @booking.arrival_date - 1.day
    assert_not @booking.valid?
  end
end
