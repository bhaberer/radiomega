class Ircnick < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :nick, presence: true,
                   uniqueness: true
end
