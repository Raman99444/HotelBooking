require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    sign_in @user
    @booking = create(:booking, user: @user)  # Use FactoryBot to create a booking
  end

  test "should get my_bookings" do
    get my_bookings_path
    assert_response :success
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

  test "should get edit" do
    get edit_booking_path(@booking)
    assert_response :success
  end

  test "should update booking" do
    patch booking_path(@booking), params: { booking: { hotel_name: 'Updated Hotel' } }
    assert_redirected_to my_bookings_path
  end

  test "should destroy booking" do
    assert_difference('Booking.count', -1) do
      delete booking_path(@booking)
    end

    assert_redirected_to my_bookings_path
  end
end
