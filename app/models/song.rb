class Song < ActiveRecord::Base
  has_many :plays, dependant: :destroy
end
