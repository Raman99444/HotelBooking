require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    sign_in @user
  end

  test "devise routes" do
    assert_routing({ method: 'post', path: '/users/sign_in' }, { controller: 'devise/sessions', action: 'create' })
    assert_routing({ method: 'delete', path: '/users/sign_out' }, { controller: 'devise/sessions', action: 'destroy' })
  end

  test "authenticated root route" do
    get authenticated_root_path
    assert_response :success
    assert_select "h5", "Basic Information"
  end

  test "unauthenticated root route" do
    sign_out @user
    get unauthenticated_root_path
    assert_response :success
    assert_select "h2", "Login"
  end

  test "profile routes" do
    assert_routing({ method: 'get', path: '/profile/edit' }, { controller: 'profiles', action: 'edit' })
    assert_routing({ method: 'patch', path: '/profile' }, { controller: 'profiles', action: 'update' })

    get profile_path
    assert_response :success
  end

  test "bookings routes" do
    assert_routing '/bookings', controller: 'bookings', action: 'index'
    assert_routing({ method: 'post', path: '/bookings' }, { controller: 'bookings', action: 'create' })
    assert_routing({ method: 'get', path: '/bookings/new' }, { controller: 'bookings', action: 'new' })
    assert_routing({ method: 'get', path: '/bookings/1' }, { controller: 'bookings', action: 'show', id: '1' })
    assert_routing({ method: 'get', path: '/bookings/1/edit' }, { controller: 'bookings', action: 'edit', id: '1' })
    assert_routing({ method: 'patch', path: '/bookings/1' }, { controller: 'bookings', action: 'update', id: '1' })
    assert_routing({ method: 'put', path: '/bookings/1' }, { controller: 'bookings', action: 'update', id: '1' })
    assert_routing({ method: 'delete', path: '/bookings/1' }, { controller: 'bookings', action: 'destroy', id: '1' })
  end

  test "my bookings route" do
    assert_routing '/my_bookings', controller: 'bookings', action: 'my_bookings'
  end
end
