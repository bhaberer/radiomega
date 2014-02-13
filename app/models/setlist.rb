class Setlist < ActiveRecord::Base
  has_many :plays
  has_many :songs, through: :plays

  def self.for_date(time)
    find_or_create_by(title: time.strftime('%F'))
  end
end
