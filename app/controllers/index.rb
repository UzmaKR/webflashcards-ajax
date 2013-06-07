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
    session[:num_correct] += 1
    @message = "Correct!"
  else
    session[:num_incorrect] += 1
    @message = "You suck at this game! The answer is obviously #{answer}."
  end

  @card = Deck.find(session[:id]).cards.sample

  erb :game
end

get '/deck/:id' do
  
  session[:id] = params[:id]
  session[:num_correct] = 0
  # session[:num_guessed] = 0
  session[:num_incorrect] = 0
  @card = Deck.find(session[:id]).cards.sample
  erb :game
end

get '/results' do 

  @num_incorrect = session[:num_incorrect]
  @num_correct = session[:num_correct]
  @deck_topic = Deck.find(session[:id]).topic

  Round.create(num_correct: @num_correct, num_incorrect: @num_incorrect,
               deck_id: session[:id])
  session.clear
  erb :results
end
