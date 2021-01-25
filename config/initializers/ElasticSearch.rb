
config = {
  host: ENV['ELASTICSEARCH_URL'],
  transport_options: { request: { timeout: 5 } }
}

Elasticsearch::Model.client = Elasticsearch::Client.new(config)
