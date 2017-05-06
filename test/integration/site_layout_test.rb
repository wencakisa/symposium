require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "site layout" do
    get root_path

    assert_select 'a[href=?]', root_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', login_path
  end

  test "page titles" do
    get root_path
    assert_select 'title', full_title

    get about_path
    assert_select 'title', full_title('About')

    get help_path
    assert_select 'title', full_title('Help')

    get users_path
    assert_select 'title', full_title('Users')

    get signup_path
    assert_select 'title', full_title('Sign up')

    get login_path
    assert_select 'title', full_title('Log in')
  end
end
