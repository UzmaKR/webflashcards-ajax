get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/play' do
  @card = Card.random


  erb :game
end
