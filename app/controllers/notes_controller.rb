class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json
  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    if @note.save
      render json: render_to_string( template:'notes/show.json.jbuilder')
    else
      respond_with @note, :location => url_for([@note])
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
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

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_with @note, :location => url_for([Note])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.includes(:taggings => [:tag]).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:name, :content, :tag_list)
    end
end
