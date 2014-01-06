class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def index
    @notes = Note.all
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
    def set_note
      @note = Note.includes(:taggings => [:tag]).find(params[:id])
    end

    def note_params
      params.require(:note).permit(:name, :content, :tag_list)
    end
end
