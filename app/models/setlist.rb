class Setlist < ActiveRecord::Base
  has_many :plays, dependent: :destroy
  has_many :songs, through: :plays

  validates :title,   presence: true

  default_scope order('title desc')

  def self.for_date(time)
    find_or_create_by(title: time.strftime('%F'))
  end

  def first_song
    songs.order('time').first.youtube_id
  end

  def playlist
    playlist = songs.order('time').map(&:youtube_id)[1..-1]
    playlist = [playlist] unless playlist.is_a?(Array)
    playlist.join(',')
  end
end
