require 'nokogiri'
require 'open-uri'
# Song Class
class Song < ActiveRecord::Base
  has_many :plays, dependent: :destroy
  has_many :setlists, through: :plays

  validates :artist,  presence: true
  validates :title,   presence: true

  default_scope { order([:artist, :title]) }

  after_create :update_youtube_id
  after_save :update_youtube_id

  def play_count
    plays.count
  end

  def song_text
    "#{title} - #{artist}".split.map(&:capitalize).join(' ')
  end

  def youtube_link
    if youtube_id.nil?
      "https://youtube.com/results?search_query=#{artist}+-+#{title}"
    else
      "https://youtube.com/watch?v=#{youtube_id}"
    end
  end

  def youtube_thumb
    "https://i1.ytimg.com/vi/#{youtube_id}/mqdefault.jpg"
  end

  def self.youtubed
    where('youtube_id IS NOT NULL')
  end

  def update_youtube_id(overwrite: false)
    return unless youtube_id.nil? || overwrite
    url = "https://www.youtube.com/results?search_query=#{artist}+-+#{title}".gsub(/\s/, '%20')
    url = URI.escape("https://www.youtube.com/results?search_query=#{artist}+-+#{title}")
    doc = Nokogiri::HTML(open(url, { ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE }))
    id = doc.xpath("//div[@id='results']/ol[1]/li[1]/ol[1]/li[1]/div[1]")
         .attribute('data-context-item-id').content
    update_attribute(:youtube_id, id) unless id.nil?
    self
  rescue NoMethodError
    puts 'Got no method error, Youtube probably changed their page again.'
    false
  end
end
