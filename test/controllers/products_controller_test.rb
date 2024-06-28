require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @user = users(:one)
    @seller = sellers(:one)
    @new_product_params = { name: 'New Product', description: 'New product description', price: 100.0, stock: 10 }
    @update_product_params = { name: 'Updated Product', description: 'Updated product description', price: 150.0, stock: 5 }
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new if seller" do
    log_in_as(@user)
    @user.create_seller

    get new_product_url
    assert_response :success
  end

  test "should create product if seller" do
    log_in_as(@user)
    @user.create_seller

    assert_difference("Product.count") do
      post products_url, params: { product: @new_product_params }
    end

    assert_redirected_to product_url(Product.last)
    follow_redirect!
    assert_select 'div.notice', 'Product was successfully created.'
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit if seller" do
    log_in_as(@user)
    @user.create_seller

    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product if seller" do
    log_in_as(@user)
    @user.create_seller

    patch product_url(@product), params: { product: @update_product_params }
    assert_redirected_to product_url(@product)
    follow_redirect!
    assert_select 'div.notice', 'Product was successfully updated.'
  end

  test "should destroy product if seller" do
    log_in_as(@user)
    @user.create_seller

    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
    follow_redirect!
    assert_select 'div.notice', 'Product was successfully destroyed.'
  end

  test "should not get new if not seller" do
    log_in_as(@user)

    get new_product_url
    assert_redirected_to products_url
    follow_redirect!
    assert_select 'div.alert', 'Only sellers can create products.'
  end

  test "should not create product if not seller" do
    log_in_as(@user)

    assert_no_difference("Product.count") do
      post products_url, params: { product: @new_product_params }
    end

    assert_redirected_to products_url
    follow_redirect!
    assert_select 'div.alert', 'Only sellers can create products.'
  end

  test "should not get edit if not seller" do
    log_in_as(@user)

    get edit_product_url(@product)
    assert_redirected_to products_url
    follow_redirect!
    assert_select 'div.alert', 'Only sellers can edit products.'
  end

  test "should not update product if not seller" do
    log_in_as(@user)

    patch product_url(@product), params: { product: @update_product_params }
    assert_redirected_to products_url
    follow_redirect!
    assert_select 'div.alert', 'Only sellers can update products.'
  end

  test "should not destroy product if not seller" do
    log_in_as(@user)

    assert_no_difference("Product.count") do
      delete product_url(@product)
    end

    assert_redirected_to products_url
    follow_redirect!
    assert_select 'div.alert', 'Only sellers can delete products.'
  end

  private

  # Helper method to log in as a specific user
  def log_in_as(user)
    post login_url, params: { email: user.email, password: 'password' }
  end
end
