json.array!(@stats) do |stat|
  json.extract! stat, :id, :value, :set_point, :auto
  json.url stat_url(stat, format: :json)
end
