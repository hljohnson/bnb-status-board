json.extract! task, :id, :description, :end_date, :created_at, :updated_at
json.url task_url(task, format: :json)