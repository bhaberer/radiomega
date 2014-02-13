class Song < ActiveRecord::Base
  has_many :plays, dependent: :destroy

  validates :artist,  presence: true
  validates :title,   presence: true

  def youtube_link
    'http://youtube.com/results?search_query=' +
    "#{artist}+-+#{title}"
  end
end
