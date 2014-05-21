class AddNoteTaggingsCountToNoteTag < ActiveRecord::Migration
  def change
     add_column :note_tags, :note_taggings_count, :integer, :default => 0
  end
end
