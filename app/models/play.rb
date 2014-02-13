class Play < ActiveRecord::Base
  belongs_to :song
  belongs_to :setlist

  

  def add_to_set
    set = Setlist.for_date(self.time)
    set.plays << self
  end
end
