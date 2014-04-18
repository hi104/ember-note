json.array!(@note_tags) do |note_tag|
  json.extract! note_tag, :id, :name, :color, :user_id
  json.url note_tag_url(note_tag, format: :json)
end
