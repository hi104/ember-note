json.tags do
  json.array!(tags) do |tag|
    json.extract! tag, :id, :name, :color
  end
end
