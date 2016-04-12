json.array!(@location_maps) do |location_map|
  json.extract! location_map, :id, :code, :value, :regex
  json.url location_map_url(location_map, format: :json)
end
