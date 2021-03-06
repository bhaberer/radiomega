class Play < ActiveRecord::Base
  belongs_to :song
  belongs_to :setlist

  validates :setlist, presence: true
  validates :song, presence: true

  default_scope { order('time desc') }

  def playlist_order
    order('time asc')
  end

  def add_to_scratch(user)
    user.make_scratch if user.scratch.nil?
    add_to_set(user.scratch)
  end

  def add_to_set(set = Setlist.for_date(time))
    set.plays << self
  end

  def self.api_create!(song, nick, time, set = nil)
    play = Play.new(song: song, nick: nick, time: time)
    set.nil? ? play.add_to_set : play.add_to_set(set)
    play.save
    play
  end
end
