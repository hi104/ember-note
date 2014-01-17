class TagsController < ApplicationController
  respond_to :html, :json

  def index
    tag_ids = current_user.notes.joins(:tags).select("tags.id").map(&:id)
    @tags = ActsAsTaggableOn::Tag.find(tag_ids)
    respond_with @tags
  end

end
