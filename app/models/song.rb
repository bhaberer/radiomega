class Song < ActiveRecord::Base
  has_many :plays, dependent: :destroy
end
