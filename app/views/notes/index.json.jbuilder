json.notes do
  json.array!(@notes) do |note|
    json.extract! note, :id, :name, :content, :label_color, :created_at, :updated_at
    json.tag_list(note.tag_list_string)
    json.tagging_ids do
      json.array!(note.note_taggings.map(&:id))
    end
  end
end

taggings = @notes.flat_map do |e|
  e.note_taggings
end.uniq

json.partial! 'note_taggings', taggings: taggings
