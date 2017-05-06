require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test)
    @second_user = users(:archer)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not_empty flash
    assert_redirected_to login_path
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not_empty flash
    assert_redirected_to login_path
  end

  test "should redirect edit when not correct user" do
    log_in_as(@user)
    get edit_user_path(@second_user)
    assert_empty flash
    assert_redirected_to root_path
  end

  test "should redirect update when not correct user" do
    log_in_as(@user)
    patch user_path(@second_user), params: { user: { name: @second_user.name,
                                                     email: @second_user.email } }
    assert_empty flash
    assert_redirected_to root_path
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_path
  end
end
