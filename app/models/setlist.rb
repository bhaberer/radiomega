class Setlist < ActiveRecord::Base
  has_many :plays
  has_many :songs, through: :plays

  def self.current_set
    find_or_create_by(title: Time.now.strftime('%F'))
  end
end
