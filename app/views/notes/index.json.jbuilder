json.notes do
  json.array!(@notes) do |note|
    json.extract! note, :id, :name, :content, :created_at, :updated_at
    json.tag_list((note.taggings.map do |e| e.tag.name end).join(', '))
    json.tagging_ids do
      json.array!(note.taggings.map(&:id))
    end
  end
end

taggings = @notes.flat_map do |e| e.taggings end.uniq

json.partial! 'taggings', taggings: taggings
