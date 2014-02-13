class Setlist < ActiveRecord::Base
  has_many :plays, dependent: :destroy
  has_many :songs, through: :plays

  validates :title,   presence: true

  def self.for_date(time)
    find_or_create_by(title: time.strftime('%F'))
  end
end
