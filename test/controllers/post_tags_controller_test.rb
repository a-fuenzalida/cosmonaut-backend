require 'test_helper'

class PostTagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_tag = post_tags(:one)
  end

  test "should get index" do
    get post_tags_url, as: :json
    assert_response :success
  end

  test "should create post_tag" do
    assert_difference('PostTag.count') do
      post post_tags_url, params: { post_tag: { post_id: @post_tag.post_id, tag_id: @post_tag.tag_id } }, as: :json
    end

    assert_response 201
  end

  test "should show post_tag" do
    get post_tag_url(@post_tag), as: :json
    assert_response :success
  end

  test "should update post_tag" do
    patch post_tag_url(@post_tag), params: { post_tag: { post_id: @post_tag.post_id, tag_id: @post_tag.tag_id } }, as: :json
    assert_response 200
  end

  test "should destroy post_tag" do
    assert_difference('PostTag.count', -1) do
      delete post_tag_url(@post_tag), as: :json
    end

    assert_response 204
  end
end
