class CreateNoteAttachments < ActiveRecord::Migration
  def change
    create_table :note_attachments do |t|
      t.string :attachment
      t.references :note, index: true

      t.timestamps
    end
  end
end
