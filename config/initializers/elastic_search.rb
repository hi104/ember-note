Elasticsearch::Model.client = Elasticsearch::Client.new host: ENV['ELASTIC_SEARCH_URL'], log: true
