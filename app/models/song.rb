class Song < ActiveRecord::Base
  has_many :plays, dependent: :destroy

  def youtube_link
    'http://youtube.com/results?search_query=' +
    "#{artist}+-+#{title}"
  end
end
