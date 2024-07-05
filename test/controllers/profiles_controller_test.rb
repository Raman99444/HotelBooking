require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create!(
      email: "test#{SecureRandom.hex(4)}@example.com",
      password: "password",
      password_confirmation: "password"
    )
    sign_in @user
  end

  test "should get show" do
    get profile_path
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_path
    assert_response :success
  end

  test "should update profile with valid attributes" do
    patch profile_path, params: {
      user: {
        name: "Updated Name",
        email: "updated@example.com",
        current_password: "password"
      }
    }
    assert_redirected_to profile_path
    assert_equal "Profile updated successfully", flash[:notice]
    @user.reload
    assert_equal "Updated Name", @user.name
    assert_equal "updated@example.com", @user.email
  end

  test "should not update profile with invalid current password" do
    patch profile_path, params: {
      user: {
        name: "Updated Name",
        email: "updated@example.com",
        current_password: "wrongpassword"
      }
    }
    assert_response :success
    assert_select 'div#error_explanation'
  end

  test "should update profile without changing password" do
    patch profile_path, params: {
      user: {
        name: "Updated Name",
        email: "updated@example.com",
        password: "",
        password_confirmation: "",
        current_password: "password"
      }
    }
    assert_redirected_to profile_path
    assert_equal "Profile updated successfully", flash[:notice]
    @user.reload
    assert_equal "Updated Name", @user.name
    assert_equal "updated@example.com", @user.email
  end
end
