require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      email: "unique_test#{SecureRandom.hex(4)}@example.com",
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

  test "should be allow to create without a name" do
    @user.name = nil
    assert @user.valid?
  end

  test "should be valid even if without a birthday" do
    @user.birthday = nil
    assert @user.valid?
  end

  test "should be valid even if without a gender" do
    @user.gender = nil
    assert @user.valid?
  end

  test "should be valid even if without an address" do
    @user.address = nil
    assert @user.valid?
  end

  test "should be valid even if without a pincode" do
    @user.pincode = nil
    assert @user.valid?
  end

  test "should be valid eben if without a state" do
    @user.state = nil
    assert @user.valid?
  end

  test "should destroy associated bookings" do
    @user.save
    hotel = Hotel.create!(name: "Test Hotel")
    @user.bookings.create!(
      hotel_id: hotel.id,
      price: 100.0,
      currency: "USD",
      arrival_date: Date.today + 1,
      departure_date: Date.today + 2,
      guest_name: "Guest Name",
      guest_email: "guest#{SecureRandom.hex(4)}@example.com"
    )
    assert_difference 'Booking.count', -1 do
      @user.destroy
    end
  end

  test "should generate jti on create" do
    @user.save
    assert_not_nil @user.jti
  end

  test "should generate unique jti" do
    @user.save
    another_user = User.create!(
      email: "another_test#{SecureRandom.hex(4)}@example.com",
      password: "password",
      name: "Jane Doe"
    )
    assert_not_equal @user.jti, another_user.jti
  end

  test "jwt_payload should include jti" do
    @user.save
    payload = @user.jwt_payload
    assert_equal @user.jti, payload['jti']
  end
end
