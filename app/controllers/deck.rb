get '/decks' do
  if session[:id]
    @decks = Deck.all
    erb :'/decks/index'
  else
    "ERROR"
  end
end

get '/decks/:id' do
  if session[:id]
    @deck = Deck.find_by(id: params[:id])
    @round = Round.create(user_id: session[:id], deck_id: @deck.id)
    session[:guesses] = 0
    erb :'/decks/show'
  else
    "ERROR"
  end
end

get '/decks/:deck_id/round/:id' do
  if session[:id]
    @deck = Deck.find_by(id: params[:deck_id])
    @round = Round.find_by(id: params[:id])
    erb :'/round/show'
  else
    "something"
  end
end

post '/decks/:deck_id/round/:id' do
  @deck = Deck.find_by(id: params[:deck_id])
  @round = Round.find_by(id: params[:id])
  @guess = Guess.create(round_id: @round.id, card_id: @deck.cards[session[:guesses]].id)
  if session[:guesses] <= @deck.cards.size
    if params[:answer] == @deck.cards[session[:guesses]].answer
      @guess.update_attributes(correct: true)
    else
      @guess.update_attributes(correct: false)
    end
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
  @deck = Deck.find_by(id: params[:deck_id])
  @round = Round.find_by(id: params[:id])
  @guess = Guess.where(round: @round)
  erb :'results/show'
end
