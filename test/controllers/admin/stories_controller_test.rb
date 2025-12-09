require "test_helper"

class Admin::StoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_stories_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_stories_show_url
    assert_response :success
  end

  test "should get new" do
    get admin_stories_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_stories_edit_url
    assert_response :success
  end
end
