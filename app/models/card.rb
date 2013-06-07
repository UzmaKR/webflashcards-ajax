class Card < ActiveRecord::Base
  def match?(guess)
    self.back == guess
  end

  def self.random
    Card.all.sample
  end
end
