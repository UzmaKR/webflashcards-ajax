enable :sessions

get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/play' do
  @card = Card.random
  @question = @card.front
  @answer = @card.back
  erb :game
end

post '/play' do
  guess = params[:guess]
  answer = params[:answer]
  if guess == answer
    @message = "Correct!"
  else
    @message = "You suck at this game! The answer is obviously #{answer}."
  end
  @card = Card.random
  @question = @card.front
  @answer = @card.back

  erb :game
end

get '/deck/:id' do
  
  p session[:id] = params[:id]
   # = Deck.find(params[:id])
  p @card = Deck.find(session[:id]).cards.sample
  erb :game
end
