class Deck < ActiveRecord::Base
  has_many :cards
  validates :topic, presence: true
end
