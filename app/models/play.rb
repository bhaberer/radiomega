class Play < ActiveRecord::Base
  belongs_to :song
  belongs_to :setlist

  default_scope order('time desc')

  def add_to_set
    set = Setlist.for_date(self.time)
    set.plays << self
  end
end
