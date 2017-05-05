require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "user signup with invalid information" do
    get signup_path
    assert_template 'users/new'

    assert_no_difference 'User.count' do
      post signup_path, params: {
        user: {
          name: ' ', email: ' ', password: ' ', password_confirmation: ' '
        }
      }
    end

    assert_not is_logged_in?
    assert_template 'users/new'
    assert_select 'div.alert.alert-danger'
  end

  test "user signup with valid information" do
    get signup_path
    assert_template 'users/new'

    assert_difference 'User.count', 1 do
      post signup_path, params: {
        user: {
          name: 'test',
          email: 'test@abv.bg',
          password: 'foobar',
          password_confirmation: 'foobar'
        }
      }
    end

    follow_redirect!
    assert is_logged_in?
    assert_template 'users/show'
    assert_select 'div.alert.alert-success'
  end
end
