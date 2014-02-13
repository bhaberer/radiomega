class Play < ActiveRecord::Base
  belongs_to :song
  belongs_to :setlist

  def add_to_current_set
    set = Setlist.current_set
    set.plays << self
  end
end
