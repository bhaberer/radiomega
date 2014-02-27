require 'nokogiri'
require 'open-uri'

class Song < ActiveRecord::Base
  has_many :plays, dependent: :destroy
  has_many :setlists, through: :plays

  validates :artist,  presence: true
  validates :title,   presence: true

  default_scope order([:artist, :title])

  after_create :set_youtube_id
  after_save :set_youtube_id

  def play_count
    plays.count
  end

  def song_text
    "#{title} - #{artist}".split.map(&:capitalize).join(' ')
  end

  def youtube_link
    if youtube_id.nil?
      "http://youtube.com/results?search_query=#{artist}+-+#{title}"
    else
      "http://youtube.com/watch?v=#{youtube_id}"
    end
  end

  def youtube_thumb
    "http://i1.ytimg.com/vi/#{youtube_id}/mqdefault.jpg"
  end

  def self.youtubed
    where('youtube_id IS NOT NULL')
  end

  def set_youtube_id(overwrite: false)
    return unless youtube_id.nil? || overwrite
    url = URI.escape("http://youtube.com/results?search_query=#{artist}+-+#{title}")
    doc = Nokogiri::HTML(open(url))
    video = doc.xpath("//ol[@id='search-results']/li[1]/div[1]/a")[0].attribute('href').content
    id = video[/\A\/watch\?v=(.+)\z/, 1]
    update_attribute(:youtube_id, id) unless id.nil?
    self
  rescue NoMethodError
    false
  end
end
