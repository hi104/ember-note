class NoteTagging < ActiveRecord::Base
  belongs_to :note
  belongs_to :note_tag
end
