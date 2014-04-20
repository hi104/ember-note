json.taggings do
  json.array!(taggings) do | tagging |
    json.extract! tagging, :id,  :tag_id
    json.note_id tagging.taggable_id
  end
end

tags = taggings.flat_map do |e| e.tag end.uniq

json.partial! '/tags/index', tags: tags
