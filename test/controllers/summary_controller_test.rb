require 'test_helper'

class SummaryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get summary_index_url
    assert_response :success
  end

  test "should get write" do
    get summary_write_url
    assert_response :success
  end

end
