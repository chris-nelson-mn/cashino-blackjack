# Blackjack with Friends

This project is intended to be a free and open source Blackjack app
that can be played in real time by multiple players.

## Project Status

Currently the resources for 'playing' a game via the command line
are in place, but not the interactive web app functionality. The
capability to persist deck & hand data so that state is preserved across
requests is largely in place. There is a Table controller for viewing and
managing what will be a list of available Blackjack tables. I've started
to put in some basic views for testing.

## Getting Started

Clone the repository, then run:

```ruby
  $ bundle install
  $ rake db:setup
  $ rails s
```

...which will give you a web server running locally. You can see the very
rudimentary list of tables. Each table shows the current player(s), their
hands, and the dealer's up card. You can hit and split hands, but you won't
yet bust and there is no scoring or evaluation of win / loss / push. Also
no betting, for the time being.

## 'Playing' on the command line

To get an idea for how the various non-Rails pieces come together to play a game,
you can do the following:

```ruby
  $ rails c
  app> deck = Deck.new(shuffled: true)
  app> player_hand = deck.deal
  app> dealer_hand = deck.deal
  app> player_hand.add(deck.draw)
  app> dealer_hand.add(deck.draw)
  app> Blackjack.score(player_hand) # your current score, with aces counted to make the best score
  app> player_hand.add(deck.draw) # hit
  app> player_hands = player_hand.split # split; hands will eventually be played in order
  app> Blackjack.busted?(player_hand) # has the player gone over 21?
  app> dealer_hand.add(deck.draw) # dealer acts
  app> Blackjack.result(player_hand, dealer_hand) # :win, :loss, or :push
```
