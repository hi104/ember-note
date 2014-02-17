class NoteAttachmentsController < ApplicationController
  layout "login"
  before_action :set_note_attachment, only: [:show, :edit, :update, :destroy]
  before_action :set_note

  # GET /note_attachments
  # GET /note_attachments.json
  def index
    @note_attachments = NoteAttachment.all
  end

  # GET /note_attachments/1
  # GET /note_attachments/1.json
  def show
  end

  # GET /note_attachments/new
  def new
    @note_attachment = NoteAttachment.new
  end

  # GET /note_attachments/1/edit
  def edit
  end

  # POST /note_attachments
  # POST /note_attachments.json
  def create
    @note_attachment = NoteAttachment.new(note_attachment_params)
    @note_attachment.note = @note
    respond_to do |format|
      if @note_attachment.save
        format.html { redirect_to @note_attachment, notice: 'Note attachment was successfully created.' }
        format.json { render action: 'show' }
      else
        format.html { render action: 'new' }
        format.json { render json: @note_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /note_attachments/1
  # PATCH/PUT /note_attachments/1.json
  def update
    respond_to do |format|
      if @note_attachment.update(note_attachment_params)
        format.html { redirect_to @note_attachment, notice: 'Note attachment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @note_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /note_attachments/1
  # DELETE /note_attachments/1.json
  def destroy
    @note_attachment.destroy
    respond_to do |format|
      format.html { redirect_to note_attachments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note_attachment
      @note_attachment = NoteAttachment.find(params[:id])
    end

    def set_note
      @note = Note.find(params[:note_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_attachment_params
      params.require(:note_attachment).permit(:attachment, :note_id)
    end
end
