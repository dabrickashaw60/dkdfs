require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get pages_home_url
    assert_response :success
  end

  test "should get schedule" do
    get pages_schedule_url
    assert_response :success
  end

  test "should get standings" do
    get pages_standings_url
    assert_response :success
  end
end
