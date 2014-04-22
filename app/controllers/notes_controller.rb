class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  respond_to :html, :json


  def index
    @notes = current_user.notes.includes(:note_taggings => :note_tag)
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
    @note.note_tags = NoteTag.create_from_string(@note.user, note_params[:tag_list])
    if @note.save
      render json: render_to_string( template:'notes/show.json.jbuilder')
    else
      respond_with @note, :location => url_for([@note])
    end
  end

  def update
    @note.update_attributes(note_params)
    @note.note_tags = NoteTag.create_from_string(@note.user, note_params[:tag_list])
    if @note.valid?
      @note_updated = Note.includes(:note_taggings => [:note_tag]).find(@note.id)
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
      raise UserNotAuthorized if note.user_id != current_user.id
    end

    def set_note
      @note = Note.includes(:note_taggings => [:note_tag]).find(params[:id])
      check_user_note!(@note)
    end

    def note_params
      params.require(:note).permit(:name, :content, :label_color, :tag_list)
    end
end
