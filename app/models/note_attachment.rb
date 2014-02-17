class NoteAttachment < ActiveRecord::Base
  belongs_to :note
  mount_uploader :attachment, AttachmentUploader
  validates :attachment,
  :presence => true,
  :file_size => {
    :maximum => 0.5.megabytes.to_i
  }
  validates :note, :presence => true
end
