json.extract! task, :id, :name, :description, :starts_at, :end_at, :status, :created_at, :updated_at
json.url task_url(task, format: :json)
