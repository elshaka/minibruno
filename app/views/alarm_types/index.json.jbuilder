json.array!(@alarm_types) do |alarm_type|
  json.extract! alarm_type, :id, :description
  json.url alarm_type_url(alarm_type, format: :json)
end
