require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    sign_in @user
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
      post bookings_path, params: { booking: { hotel_name: 'Test Hotel', price: 100.0, currency: 'USD', arrival_date: Date.today + 1, departure_date: Date.today + 2, guest_name: 'Guest Name', guest_email: 'guest@example.com' } }
    end

    assert_redirected_to my_bookings_path
  end

  test "should create booking with JSON format" do
    assert_difference('Booking.count') do
      post bookings_path, params: { booking: { hotel_name: 'Test Hotel', price: 100.0, currency: 'USD', arrival_date: Date.today + 1, departure_date: Date.today + 2, guest_name: 'Guest Name', guest_email: 'guest@example.com' } }, as: :json
    end

    assert_response :created
    json_response = JSON.parse(response.body)
    assert_equal 'Test Hotel', json_response['hotel_name']
  end

  test "should get edit" do
    booking = create(:booking, user: @user)
    get edit_booking_path(booking)
    assert_response :success
  end

  test "should update booking" do
    booking = create(:booking, user: @user) 
    patch booking_path(booking), params: { booking: { hotel_name: 'Updated Hotel' } }
    assert_redirected_to my_bookings_path
    booking.reload
    assert_equal 'Updated Hotel', booking.hotel_name
  end

  test "should update booking with JSON format" do
    booking = create(:booking, user: @user)
    patch booking_path(booking), params: { booking: { hotel_name: 'Updated Hotel' } }, as: :json
    assert_response :ok
    json_response = JSON.parse(response.body)
    assert_equal 'Updated Hotel', json_response['hotel_name']
  end

  test "should destroy booking" do
    booking = create(:booking, user: @user)
    assert_difference('Booking.count', -1) do
      delete booking_path(booking)
    end

    assert_redirected_to my_bookings_path
  end

  test "should destroy booking with JSON format" do
    booking = create(:booking, user: @user)
    assert_difference('Booking.count', -1) do
      delete booking_path(booking), as: :json
    end

    assert_response :no_content
  end
end
