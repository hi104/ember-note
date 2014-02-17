json.array!(@note_attachments) do |note_attachment|
  json.extract! note_attachment, :id, :attachment, :note_id
  json.url note_attachment_url(note_attachment, format: :json)
end
