require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "user signup with invalid information" do
    get signup_url
    assert_template 'users/new'

    assert_no_difference 'User.count' do
      post signup_path, params: {
        user: {
          name: ' ', email: ' ', password: ' ', password_confirmation: ' '
        }
      }
    end

    assert_template 'users/new'
    assert_select 'div.alert.alert-danger'
  end

  test "user signup with valid information" do
    get signup_url
    assert_template 'users/new'

    assert_difference 'User.count', 1 do
      post signup_path, params: {
        user: {
          name: 'test',
          email: 'test@gmail.com',
          password: 'foobar',
          password_confirmation: 'foobar'
        }
      }
    end

    follow_redirect!
    assert_template 'users/show'
    assert_select 'div.alert.alert-success'
  end
end
