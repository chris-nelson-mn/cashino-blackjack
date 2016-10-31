# Blackjack with Friends

This project is intended to be a free and open source Blackjack app
that can be played in real time by multiple players.

## Design Goals

For version 1 of the app, I'm aiming for the following feature highlights:

* Card / Deck / Hand / Player classes which are decoupled from the rules
of Blackjack, so they could be re-used to make, say, a Poker game
* Tables of up to 8 Players, with drop-in, drop-out capability
* User accounts with a Bank for tracking money. User is connected to a Table via Player.
* Per-Table game state data channel using ActionCable so games can play out in real time for multiple players
* Per-Table chat channel using ActionCable for table talk
* Animated SVG card images which move according to incoming game state changes

## Project Status

So those design goals should be a lot of fun once hit. But where are we now?

Currently the resources for 'playing' a game via the command line
are in place, but not much of the interactive web app functionality. The
capability to persist deck & hand data so that state is preserved across
requests is largely in place. There is a Table controller for viewing and
managing what will be a list of available Blackjack tables. The Player controller
is handling some gameplay actions. I've started to put in some basic views for testing.

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
