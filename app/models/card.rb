class Card < ActiveRecord::Base
  belongs_to :deck
  validates :front, presence: true
  def match?(guess)
    self.back == guess
  end

  def self.random
    Card.all.sample
  end
end
