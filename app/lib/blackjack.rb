class Blackjack
  def initialize(deck)
    @deck = deck
  end

  def deal
    Hand.new(@deck, 2)
  end
end
