json.extract! job, :id, :name, :address, :client, :notes, :job_number, :created_at, :updated_at
json.url job_url(job, format: :json)
