json.tag do
  json.extract! @tag, :id, :name, :color, :taggings_count
end
