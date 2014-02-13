json.array!(@plays) do |play|
  json.extract! play, :id, :nick, :song_id
  json.url play_url(play, format: :json)
end
