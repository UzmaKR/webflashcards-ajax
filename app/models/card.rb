class Card < ActiveRecord::Base
  def match?(guess)
    self.back == guess
  end
end
