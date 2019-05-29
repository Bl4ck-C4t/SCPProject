require 'test_helper'

class ScpControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get scp_index_url
    assert_response :success
  end

  test "should get show" do
    get scp_show_url
    assert_response :success
  end

  test "should get create" do
    get scp_create_url
    assert_response :success
  end

  test "should get update" do
    get scp_update_url
    assert_response :success
  end

  test "should get destroy" do
    get scp_destroy_url
    assert_response :success
  end

end
