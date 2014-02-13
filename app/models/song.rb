require 'nokogiri'
require 'open-uri'

class Song < ActiveRecord::Base
  has_many :plays, dependent: :destroy

  validates :artist,  presence: true
  validates :title,   presence: true

  after_create :set_youtube_link

  def set_youtube_link
    url = URI.escape("http://youtube.com/results?search_query=#{artist}+-+#{title}")
    doc = Nokogiri::HTML(open(url))
    video = doc.xpath("//ol[@id='search-results']/li[1]/div[1]/a")[0].attribute('href').content
    update_attribute(:youtube_link, "http://youtube.com/#{video}") unless video.nil?
  end
end
