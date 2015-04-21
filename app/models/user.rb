class User < ActiveRecord::Base
  has_one :scratch, dependent: :destroy
  has_many :set_lists

  after_create :make_scratch

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # private

  def make_scratch
    Scratch.create!(title: "#{id}_scratch", user: self)
  end
end
