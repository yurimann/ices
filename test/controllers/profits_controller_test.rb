require 'test_helper'

class ProfitsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get profits_index_url
    assert_response :success
  end

  test "should get month" do
    get profits_month_url
    assert_response :success
  end

  test "should get year" do
    get profits_year_url
    assert_response :success
  end

end
