require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    sign_in @user
    @hotel = Hotel.create!(name: "Test Hotel")
  end

  test "should get my_bookings" do
    get my_bookings_path
    assert_response :success
  end

  test "should get my_bookings with JSON format" do
    get my_bookings_path, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal @user.bookings.count, json_response.size
  end

  test "should get new" do
    get new_booking_path
    assert_response :success
  end

  test "should create booking" do
    assert_difference('Booking.count') do
      post bookings_path, params: { booking: { hotel_id: @hotel.id.to_s, price: 100.0, currency: 'USD', arrival_date: Date.today + 1, departure_date: Date.today + 2, guest_name: 'Guest Name', guest_email: 'guest@example.com' } }
    end

    assert_redirected_to my_bookings_path
  end

  test "should create booking with JSON format" do
    assert_difference('Booking.count') do
      post bookings_path, params: { booking: { hotel_id: @hotel.id.to_s, price: 100.0, currency: 'USD', arrival_date: Date.today + 1, departure_date: Date.today + 2, guest_name: 'Guest Name', guest_email: 'guest@example.com' } }, as: :json
    end

    assert_response :created
    json_response = JSON.parse(response.body)
    assert_equal @hotel.name, json_response['hotel']['name']
  end

  test "should get edit" do
    booking = create(:booking, user: @user, hotel: @hotel)
    get edit_booking_path(booking)
    assert_response :success
  end

  test "should update booking" do
    booking = create(:booking, user: @user, hotel: @hotel) 
    patch booking_path(booking), params: { booking: { price: 200.0 } }
    assert_redirected_to my_bookings_path
    booking.reload
    assert_equal 200.0, booking.price
  end

  test "should update booking with JSON format" do
    booking = create(:booking, user: @user, hotel: @hotel)
    patch booking_path(booking), params: { booking: { price: 200.0 } }, as: :json
    assert_response :ok
    json_response = JSON.parse(response.body)
    assert_equal 200.0, json_response['price']
  end

  test "should destroy booking" do
    booking = create(:booking, user: @user, hotel: @hotel)
    assert_difference('Booking.count', -1) do
      delete booking_path(booking)
    end

    assert_redirected_to my_bookings_path
  end

  test "should destroy booking with JSON format" do
    booking = create(:booking, user: @user, hotel: @hotel)
    assert_difference('Booking.count', -1) do
      delete booking_path(booking), as: :json
    end

    assert_response :no_content
  end
end
