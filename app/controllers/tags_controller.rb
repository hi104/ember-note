class TagsController < ApplicationController
  respond_to :html, :json

  def index
    @tags = ActsAsTaggableOn::Tag.includes([:taggings]).find_all do |e|
      e.taggings.count > 0
    end
    respond_with @tags
  end

end
