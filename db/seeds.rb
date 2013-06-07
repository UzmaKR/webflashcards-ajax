
deck_add = Deck.create(topic: "Addition")
deck_mult = Deck.create(topic: "Multiplication")

(1..10).each do |i|
  (1..10).each do |j|
    deck_add.cards << Card.create(front: "#{i} + #{j}",
                back: "#{i+j}")
  end
end

(1..10).each do |i|
  (1..10).each do |j|
    deck_mult.cards << Card.create(front: "#{i} * #{j}",
                back: "#{i*j}")
  end
end

