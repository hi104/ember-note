note = @note
json.note do
  json.extract! note, :id, :name, :content, :created_at, :updated_at
  json.tag_list(note.tag_list_string)
  json.tagging_ids do
    json.array!(note.taggings.map(&:id))
  end
end

taggings = [note].flat_map do |e| e.taggings end.uniq

json.partial! 'taggings', taggings: taggings
