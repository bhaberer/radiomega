class Song < ActiveRecord::Base
  has_many :plays
end
