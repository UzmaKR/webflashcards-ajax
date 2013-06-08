enable :sessions

get '/' do
  session.clear if session[:round_id]
  # Look in app/views/index.erb
  erb :welcome
end

post '/play' do
  guess = params[:guess]
  answer = params[:answer]
  if guess == answer
    session[:num_correct] += 1
    session[:card_ids].delete(session[:current_card])
    @message = "Correct!"
  else
    session[:num_incorrect] += 1
    @message = "You suck at this game! The answer is obviously #{answer}."
  end

  redirect '/results' if session[:card_ids].empty?
  
  session[:current_card] = session[:card_ids].sample
  @card = Card.find(session[:current_card])
  
  erb :game
end

get '/decks' do
  erb :deck_list
end

get '/deck/:id' do
  session[:round_id] = params[:id]
  session[:num_correct] = 0
  # session[:num_guessed] = 0
  session[:num_incorrect] = 0
  session[:card_ids] = Deck.find(session[:round_id]).cards.map {|card| card.id}
  session[:current_card] = session[:card_ids].sample
  @card = Card.find(session[:current_card])
  erb :game
end

get '/results' do 

  p session
  # @num_incorrect = session[:num_incorrect]
  # @num_correct = session[:num_correct]
  # @deck_topic = Deck.find(session[:round_id]).topic
  # @user_id = session[]

  @round = Round.create(num_correct: session[:num_correct], 
                        num_incorrect: session[:num_incorrect],
                          deck_id: session[:round_id], 
                          user_id: session[:user_id])
  #session.clear
  erb :results
end
