class CreateNoteTags < ActiveRecord::Migration
  def change
    create_table :note_tags do |t|
      t.string :name
      t.string :color
      t.references :user, index: true

      t.timestamps
    end
  end
end
