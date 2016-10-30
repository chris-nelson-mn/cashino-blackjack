class Blackjack
  def initialize(deck)
    @deck = deck
  end

  def deal
    @deck.draw
  end
end
