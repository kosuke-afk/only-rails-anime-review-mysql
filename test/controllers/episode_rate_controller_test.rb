require "test_helper"

class EpisodeRateControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get episode_rate_edit_url
    assert_response :success
  end
end
