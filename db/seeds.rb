
(1..10).each do |i|
  (1..10).each do |j|
    Card.create(front: "#{i} + #{j}",
                back: "#{i+j}")
  end
end
