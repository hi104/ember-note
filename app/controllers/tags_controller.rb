class TagsController < ApplicationController
  respond_to :html, :json

  def index
    tag_ids = current_user.notes.joins(:note_tags).select("note_tags.id").map(&:id)
    @tags = NoteTag.find(tag_ids)
    respond_with @tags
  end

end
