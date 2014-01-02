json.taggings do
  json.array!(taggings) do | tagging |
    json.extract! tagging, :id,  :tag_id
    json.note_id tagging.taggable_id
  end
end

tags = taggings.flat_map do |e| e.tag end.uniq

json.tags do
  json.array!(tags) do | tag |
    json.extract! tag, :id, :name
    # json.tagging_ids do
    #   json.array!(tag.taggings.map(&:id))
    # end
  end
end
