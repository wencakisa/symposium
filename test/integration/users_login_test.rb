require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'

    post login_path, params: { session: { email: @user.email, password: ' ' } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_select 'div.alert.alert-danger'
  end

  test "login with valid information followed by logout" do
    get login_path
    assert_template 'sessions/new'

    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert is_logged_in?
    assert_template 'users/show'
    assert_select 'div.alert.alert-success'
    assert_select 'a[href=?]', users_path
    assert_select 'a[href=?]', user_path
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', login_path, count: 0

    delete logout_path
    assert_redirected_to root_path
    assert_not is_logged_in?
    # Simulating a user clicking logout in a second window.
    delete logout_path
    # ---
    follow_redirect!
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', logout_path, count: 0
  end
end
