# Model for scratchs
class Scratch < Setlist
  validates :user, presence: true,
                   uniqueness: true
end
