class NoteTagging < ActiveRecord::Base
  belongs_to :note
  belongs_to :note_tag, :counter_cache => true
end
