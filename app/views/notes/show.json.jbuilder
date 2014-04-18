note = @note
json.note do
  json.extract! note, :id, :name, :content, :label_color, :created_at, :updated_at
  json.tag_list(note.tag_list_string)
  json.tagging_ids do
    json.array!(note.note_taggings.map(&:id))
  end
end

taggings = [note].flat_map do |e| e.note_taggings end.uniq

json.partial! 'note_taggings', taggings: taggings
