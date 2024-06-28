require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "should get new" do
    get login_path
    assert_response :success
    assert_select "form"
  end

  test "should create session with valid credentials" do
    post login_path, params: { email: @user.email, password: 'password' }
    assert_redirected_to products_path
    assert_equal flash[:notice], "Logged in successfully."
    assert session[:user_id] == @user.id
  end

  test "should not create session with invalid credentials" do
    post login_path, params: { email: @user.email, password: 'wrongpassword' }
    assert_response :success
    assert_template :new
    assert_equal flash[:alert], "Invalid email or password."
    assert_nil session[:user_id]
  end

  test "should destroy session" do
    delete logout_path
    assert_redirected_to login_path
    assert_equal flash[:notice], "Logged out successfully."
    assert_nil session[:user_id]
  end
end
