json.array!(@setlists) do |setlist|
  json.extract! setlist, :id
  json.url setlist_url(setlist, format: :json)
end
