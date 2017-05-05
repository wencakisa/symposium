require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "page titles" do
    get root_url
    assert_select 'title', full_title

    get about_url
    assert_select 'title', full_title('About')

    get help_url
    assert_select 'title', full_title('Help')
  end
end
