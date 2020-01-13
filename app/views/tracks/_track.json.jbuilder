json.extract! track, :id, :name, :description, :starts_at, :ends_at, :status, :created_at, :updated_at
json.url track_url(track, format: :json)
