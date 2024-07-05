require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      email: "unique_test@example.com",
      password: "password",
      name: "John Doe",
      birthday: Date.new(1990, 1, 1),
      gender: "Male",
      address: "123 Main St",
      pincode: "123456",
      state: "Test State"
    )
  end

  test "should be valid with valid attributes" do
    assert @user.valid?, @user.errors.full_messages.to_sentence
  end

  test "should be invalid without an email" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "should be invalid without a password" do
    @user.password = nil
    assert_not @user.valid?
  end

  test "should be invalid without a name" do
    @user.name = nil
    assert_not @user.valid?
  end

  test "should be valid even if without a birthday" do
    @user.birthday = nil
    assert @user.valid?
  end

  test "should be invalid without a gender" do
    @user.gender = nil
    assert_not @user.valid?
  end

  test "should be invalid without an address" do
    @user.address = nil
    assert_not @user.valid?
  end

  test "should be invalid without a pincode" do
    @user.pincode = nil
    assert_not @user.valid?
  end

  test "should be invalid without a state" do
    @user.state = nil
    assert_not @user.valid?
  end

  test "should destroy associated bookings" do
    @user.save
    @user.bookings.create!(
      hotel_name: "Test Hotel",
      price: 100.0,
      currency: "USD",
      arrival_date: Date.today + 1,
      departure_date: Date.today + 2,
      guest_name: "Guest Name",
      guest_email: "guest@example.com"
    )
    assert_difference 'Booking.count', -1 do
      @user.destroy
    end
  end
end
