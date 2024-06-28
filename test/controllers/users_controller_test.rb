require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @new_user_params = { email: 'newuser@example.com', password: 'password', password_confirmation: 'password' }
    @update_user_params = { email: 'updateduser@example.com', password: 'newpassword', password_confirmation: 'newpassword' }
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: @new_user_params }
    end
    assert_redirected_to products_url
    follow_redirect!
    assert_select 'div.notice', 'User was successfully created.'
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: @update_user_params }
    assert_redirected_to user_url(@user)
    follow_redirect!
    assert_select 'div.notice', 'User was successfully updated.'
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end
    assert_redirected_to users_url
    follow_redirect!
    assert_select 'div.notice', 'User was successfully destroyed.'
  end

  test "should not create user with invalid params" do
    assert_no_difference("User.count") do
      post users_url, params: { user: { email: '', password: 'password', password_confirmation: 'password' } }
    end
    assert_response :unprocessable_entity
    assert_select 'div.alert', 'Error creating user.'
  end

  test "should not update user with invalid params" do
    patch user_url(@user), params: { user: { email: '', password: 'newpassword', password_confirmation: 'newpassword' } }
    assert_response :unprocessable_entity
    assert_select 'div.alert', 'Error updating user.'
  end
end
