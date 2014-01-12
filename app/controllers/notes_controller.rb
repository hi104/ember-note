class User::NotAuthorized < Exception
end
class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  respond_to :html, :json

  rescue_from User::NotAuthorized, with: :user_not_authorized

  def index
    @notes = current_user.notes
    # @notes = Note.all
  end

  def show
  end

  def new
    @note = Note.new
  end

  def edit
  end

  def create
    @note = Note.new(note_params)
    @note.user = current_user
    if @note.save
      render json: render_to_string( template:'notes/show.json.jbuilder')
    else
      respond_with @note, :location => url_for([@note])
    end
  end

  def update
    @note.update_attributes(note_params)
    if @note.valid?
      @note_updated = Note.includes(:taggings => [:tag]).find(@note.id)
      @note =  @note_updated #for updated tag
      render json: render_to_string( template:'notes/show.json.jbuilder')
    else
      respond_with @note, :location => url_for([@note])
    end
  end

  def destroy
    @note.destroy
    respond_with @note, :location => url_for([Note])
  end

  private

    def check_user_note!(note)
      raise User::NotAuthorized if note.user_id != current_user.id
    end

    def user_not_authorized
      render :json => {:error => "error user_not_authorized"}, :status => 401
    end

    def set_note
      @note = Note.includes(:taggings => [:tag]).find(params[:id])
      check_user_note!(@note)
    end

    def note_params
      params.require(:note).permit(:name, :content, :tag_list)
    end
end
