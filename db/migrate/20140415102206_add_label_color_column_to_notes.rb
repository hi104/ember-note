class AddLabelColorColumnToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :label_color, :string
  end
end
