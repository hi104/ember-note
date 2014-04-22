class TagsController < ApplicationController
  before_action :set_tag, only: [:update, :destroy]
  respond_to :html, :json

  def index
    tag_ids = current_user.notes.joins(:note_tags).select("note_tags.id").map(&:id)
    @tags = NoteTag.find(tag_ids)
    respond_with @tags
  end

  def update
    @tag.update_attributes(tag_params)
    if @tag.valid?
      render json: render_to_string( template:'tags/show.json.jbuilder')
    else
      respond_with @tag
    end
  end

  def destroy
    @tag.destroy
    respond_with @tag
  end

  private

      def set_tag
        @tag = NoteTag.find(params[:id])
        check_user_tag!(@tag)
      end

      def check_user_tag!(tag)
        raise UserNotAuthorized if tag.user_id != current_user.id
      end

      def tag_params
        params.require(:tag).permit(:name, :color)
      end
end
