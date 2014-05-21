json.tags do
  json.array!(tags) do |tag|
    json.extract! tag, :id, :name, :color, :taggings_count
  end
end
