# test/system/dashboard_test.rb
require "application_system_test_case"

class DashboardTest < ApplicationSystemTestCase
  setup do
    @user = create(:user, email: "user@example.com", password: "password") # Ensure the user has a known password
  end

  test "dashboard layout" do
    # Visit the login page and log in
    visit new_user_session_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: "password"
    click_button "Log in"

    # Check if we are redirected to the dashboard
    assert_current_path authenticated_root_path

    # Check if the profile image is displayed
    assert_selector 'img.rounded-circle'

    # Check if the user name is displayed
    assert_text @user.name

    # Check if the profile link is present and active
    assert_selector "a.nav-link.active", text: "Profile"

    # Check if the My Bookings link is present
    assert_selector "a.nav-link", text: "My Bookings"

    # Check if the Logout link is present
    assert_selector "a.nav-link", text: "Logout"

    # Check if the Bootstrap CSS is loaded
    assert_selector 'link[href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"]', visible: false
    assert_selector 'link[href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"]', visible: false

    # Check if the Bootstrap JS and other JS files are loaded
    assert_selector 'script[src="https://code.jquery.com/jquery-3.3.1.slim.min.js"]', visible: false
    assert_selector 'script[src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"]', visible: false
    assert_selector 'script[src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"]', visible: false
    assert_selector 'script[src="/assets/application.js"]', visible: false
    assert_selector 'script[src="/assets/booking_validation.js"]', visible: false
  end
end
