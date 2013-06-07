class Deck < ActiveRecord::Base
  has_many :cards
  has_many :rounds
  validates :topic, presence: true
end
