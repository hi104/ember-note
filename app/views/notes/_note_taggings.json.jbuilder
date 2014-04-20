json.taggings do
  json.array!(taggings) do | tagging |
    json.extract! tagging, :id
    json.tag_id tagging.note_tag_id
    json.note_id tagging.note_id
  end
end

tags = taggings.flat_map do |e| e.note_tag end.uniq

json.partial! '/tags/index', tags: tags
