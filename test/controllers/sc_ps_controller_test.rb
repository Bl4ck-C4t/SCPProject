require 'test_helper'

class ScPsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scp = scps(:one)
  end

  test "should get index" do
    get scps_url
    assert_response :success
  end

  test "should get new" do
    get new_scp_url
    assert_response :success
  end

  test "should create scp" do
    assert_difference('Scp.count') do
      post scps_url, params: { scp: {  } }
    end

    assert_redirected_to scp_url(Scp.last)
  end

  test "should show scp" do
    get scp_url(@scp)
    assert_response :success
  end

  test "should get edit" do
    get edit_scp_url(@scp)
    assert_response :success
  end

  test "should update scp" do
    patch scp_url(@scp), params: { scp: {  } }
    assert_redirected_to scp_url(@scp)
  end

  test "should destroy scp" do
    assert_difference('Scp.count', -1) do
      delete scp_url(@scp)
    end

    assert_redirected_to scps_url
  end
end
