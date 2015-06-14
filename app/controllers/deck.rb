get '/decks' do
  if is_authenticated?
    @decks = Deck.all
    erb :'/decks/index'
  else
    @errors = "Sorry, you must be logged in to view our decks."
    erb :sorry
  end
end

get '/decks/:id' do
  if is_authenticated?
    @deck = Deck.find_by(id: params[:id])
    @round = Round.create(user_id: session[:id], deck_id: @deck.id)
    session[:guesses] = 0
    erb :'/decks/show'
  else
    @errors = "Sorry, you must be logged in to view this deck."
    erb :sorry
  end
end

get '/decks/:deck_id/round/:id' do
  if is_authenticated?
    @deck = Deck.find_by(id: params[:deck_id])
    @round = Round.find_by(id: params[:id])
    erb :'/round/show'
  else
    @errors = "Sorry, you must be logged in to play this deck"
    erb :sorry
  end
end

post '/decks/:deck_id/round/:id' do
  @deck = Deck.find_by(id: params[:deck_id])
  @round = Round.find_by(id: params[:id])
  @guess = Guess.create(round_id: @round.id, card_id: @deck.cards[session[:guesses]].id)
    if params[:answer].downcase == @deck.cards[session[:guesses]].answer.downcase
      @guess.update_attributes(correct: true)
    else
      @guess.update_attributes(correct: false)
    end
  session[:guesses] += 1
  if session[:guesses] == @deck.cards.size
    redirect "decks/#{@deck.id}/round/#{@round.id}/results"
  else
    redirect "decks/#{@deck.id}/round/#{@round.id}"
  end
  erb :'/round/show'
end

get '/decks/:deck_id/round/:id/results' do
  if is_authenticated?
    @deck = Deck.find_by(id: params[:deck_id])
    @round = Round.find_by(id: params[:id])
    @guess = Guess.where(round: @round)
    erb :'results/show'
  else
    @errors = "Sorry, you must be logged in to view results."
    erb :sorry
  end
end
