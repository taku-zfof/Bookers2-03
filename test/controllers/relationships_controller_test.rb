require "test_helper"

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get fs" do
    get relationships_fs_url
    assert_response :success
  end
end
