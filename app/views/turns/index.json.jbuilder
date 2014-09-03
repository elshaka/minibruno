json.array!(@turns) do |turn|
  json.extract! turn, :id, :start_time, :end_time, :description
  json.url turn_url(turn, format: :json)
end
