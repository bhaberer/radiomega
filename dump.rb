require 'csv'

(2012..2021).each do |year|
  plays = []
  date = Time.zone.parse("#{year}-01-01")
  date_range = date.beginning_of_year..date.end_of_year

    Setlist.where(created_at: date_range).map do |setlist|
      next if setlist.songs.count.zero?

      setlist.plays.map do |play|
        play_info = { set_list_id: setlist.id, setlist_title: setlist.title, played_by: play.nick, played_at: play.time, song_title: play.song.title, song_artist: play.song.artist, song_youtube_id: play.song.youtube_id }
        p play_info
        plays << play_info
      end
    end

    next unless plays.count.positive?

    CSV.open("./year_dump_#{year}.csv", "w") do |csv|
      csv << plays.first.keys
      plays.each { |p| csv << p.values }
    end

end

