class CreateNoteTaggings < ActiveRecord::Migration
  def change
    create_table :note_taggings do |t|
      t.references :note, index: true
      t.references :note_tag, index: true

      t.timestamps
    end
  end
end
