class Deck
  DEFAULT_SUITS = %w(spades clubs diamonds hearts)
  DEFAULT_RANKS = %w(ace two three four five six seven eight nine ten jack queen king)

  def initialize(suits, ranks)
    @suits = suits
    @ranks = ranks
    @cards = Array.new

    # Top of the deck is the last entry in the array
    # Reversing so deck starts with cards in order from least to highest face value
    suits.reverse.each do |suit|
      ranks.reverse.each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
  end

  def draw
    @cards.pop
  end

  def shuffle
    @cards.shuffle!
  end
end
