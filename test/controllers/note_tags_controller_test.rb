require 'test_helper'

class NoteTagsControllerTest < ActionController::TestCase
  setup do
    @note_tag = note_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:note_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create note_tag" do
    assert_difference('NoteTag.count') do
      post :create, note_tag: { color: @note_tag.color, name: @note_tag.name, user_id: @note_tag.user_id }
    end

    assert_redirected_to note_tag_path(assigns(:note_tag))
  end

  test "should show note_tag" do
    get :show, id: @note_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @note_tag
    assert_response :success
  end

  test "should update note_tag" do
    patch :update, id: @note_tag, note_tag: { color: @note_tag.color, name: @note_tag.name, user_id: @note_tag.user_id }
    assert_redirected_to note_tag_path(assigns(:note_tag))
  end

  test "should destroy note_tag" do
    assert_difference('NoteTag.count', -1) do
      delete :destroy, id: @note_tag
    end

    assert_redirected_to note_tags_path
  end
end
