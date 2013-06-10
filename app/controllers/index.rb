enable :sessions

get '/' do
  session.clear if session[:round_id]
  erb :welcome
end

post '/play' do
  p params
  p session[:current_card]
  guess = params[:guess]
  answer = params[:answer]
  if guess == answer
    session[:num_correct] += 1
    session[:card_ids].delete(session[:current_card])
    @message = "Correct! You are doing great !"
  else
    session[:num_incorrect] += 1
    @message = "Incorrect! The answer is #{answer}."
  end

  redirect '/results' if session[:card_ids].empty?

  session[:current_card] = session[:card_ids].sample
  @card = Card.find(session[:current_card])
  
  #send answer, new card info to ajax
  content_type :json
  {message: @message, front: @card.front, back: @card.back}.to_json
  # erb :game
end

get '/decks' do
  erb :deck_list
end

get '/deck/:id' do
  session[:round_id] = params[:id]
  session[:num_correct] = 0
  session[:num_incorrect] = 0
  session[:card_ids] = Deck.find(session[:round_id]).cards.map {|card| card.id}
  session[:current_card] = session[:card_ids].sample
  @card = Card.find(session[:current_card])
  erb :game
end

get '/results' do 
  @round = Round.create(num_correct: session[:num_correct], 
                        num_incorrect: session[:num_incorrect],
                          deck_id: session[:round_id], 
                          user_id: session[:user_id])
  erb :results
end
