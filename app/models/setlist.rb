# Class for Setlists
class Setlist < ActiveRecord::Base
  has_many :plays, dependent: :destroy
  has_many :songs, through: :plays
  belongs_to :user

  validates :title,   presence: true

  default_scope { order('title desc') }

  def self.for_date(time)
    find_or_create_by(title: time.strftime('%F'))
  end

  def end
    update_attribute(:live, false)
  end

  def start
    update_attribute(:live, true)
  end

  def self.end_for_owner(owner)
    sets = where(owner: owner, live: true)
    sets.map(&:end)
  end

  def first_song
    play = valid_plays.first
    play.youtube_id unless play.nil?
  end

  def playlist
    playlist = valid_plays.map(&:youtube_id)[1..-1]
    playlist = [playlist] unless playlist.is_a?(Array)
    playlist.join(',')
  end

  def valid_plays
    list = plays.dup.sort { |x, y| x.time <=> y.time }.map(&:song)
    list.delete_if { |play| !play.youtube_id.present? }
  end
end
