require 'test_helper'

class NoteAttachmentsControllerTest < ActionController::TestCase
  setup do
    @note_attachment = note_attachments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:note_attachments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create note_attachment" do
    assert_difference('NoteAttachment.count') do
      post :create, note_attachment: { attachment: @note_attachment.attachment, note_id: @note_attachment.note_id }
    end

    assert_redirected_to note_attachment_path(assigns(:note_attachment))
  end

  test "should show note_attachment" do
    get :show, id: @note_attachment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @note_attachment
    assert_response :success
  end

  test "should update note_attachment" do
    patch :update, id: @note_attachment, note_attachment: { attachment: @note_attachment.attachment, note_id: @note_attachment.note_id }
    assert_redirected_to note_attachment_path(assigns(:note_attachment))
  end

  test "should destroy note_attachment" do
    assert_difference('NoteAttachment.count', -1) do
      delete :destroy, id: @note_attachment
    end

    assert_redirected_to note_attachments_path
  end
end
