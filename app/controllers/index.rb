enable :sessions

get '/' do
  session.clear if session[:id]
  # Look in app/views/index.erb
  erb :index
end

post '/play' do
  guess = params[:guess]
  answer = params[:answer]
  if guess == answer
    @message = "Correct!"
  else
    @message = "You suck at this game! The answer is obviously #{answer}."
  end
  @card = Deck.find(session[:id]).cards.sample

  erb :game
end

get '/deck/:id' do
  
  session[:id] = params[:id]
  @card = Deck.find(session[:id]).cards.sample
  erb :game
end
