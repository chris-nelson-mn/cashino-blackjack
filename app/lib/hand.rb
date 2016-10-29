class Hand
  attr_reader :cards

  def initialize(deck, size)
    @cards = []
    size.times { @cards << deck.draw } 
  end
end
