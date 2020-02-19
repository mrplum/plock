require 'elasticsearch/model'

if Rails.env.development?
	config = {
  		host: "http://localhost:9200/",
  		transport_options: {
    	request: { timeout: 5 }
  		}
	}
	if File.exists?("config/elasticsearch.yml")
  		config.merge!(YAML.load_file("config/elasticsearch.yml")[Rails.env].deep_symbolize_keys)
	end
else 
	config = {
  		host: "https://sxvkrp02t6:vvmms6q4rn@yew-522866683.us-east-1.bonsaisearch.net:443",
  		transport_options: {
    	request: { timeout: 5 }
  		}
	}
	if File.exists?("config/elasticsearch.yml")
  		config.merge!(YAML.load_file("config/elasticsearch.yml")[Rails.env].deep_symbolize_keys)
	end
end

Elasticsearch::Model.client = Elasticsearch::Client.new(config)