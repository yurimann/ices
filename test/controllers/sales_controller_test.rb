require 'test_helper'

class SalesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get sales_new_url
    assert_response :success
  end

  test "should get create" do
    get sales_create_url
    assert_response :success
  end

  test "should get edit" do
    get sales_edit_url
    assert_response :success
  end

  test "should get update" do
    get sales_update_url
    assert_response :success
  end

  test "should get delete" do
    get sales_delete_url
    assert_response :success
  end

end
