require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test)
  end

  test "non-logged-in user site layout" do
    get root_path

    assert_select 'a[href=?]', root_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', users_path, count: 0
    assert_select 'a[href=?]', logout_path, count: 0
  end

  test "logged-in user site layout" do
    log_in_as(@user)
    follow_redirect!

    assert_select 'a[href=?]', root_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', users_path
    assert_select 'a[href=?]', logout_path
  end

  test "page titles" do
    get root_path
    assert_select 'title', full_title

    get about_path
    assert_select 'title', full_title('About')

    get help_path
    assert_select 'title', full_title('Help')

    get signup_path
    assert_select 'title', full_title('Sign up')

    get login_path
    assert_select 'title', full_title('Log in')
  end
end
