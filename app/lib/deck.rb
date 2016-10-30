class Deck
  DEFAULT_SUITS = %w(spades clubs diamonds hearts).map(&:to_sym).freeze
  DEFAULT_RANKS = %w(ace two three four five six seven eight nine ten jack queen king).map(&:to_sym).freeze

  def initialize(options={})
    default_options = {
      suits: DEFAULT_SUITS,
      ranks: DEFAULT_RANKS,
      shuffled: false
    }
    options.reverse_merge!(default_options)

    @suits = options[:suits]
    @ranks = options[:ranks]
    @cards = Array.new

    # Top of the deck is the last entry in the array
    # Reversing so deck starts with cards in order from least to highest face value
    @suits.reverse.each do |suit|
      @ranks.reverse.each do |rank|
        @cards << Card.new(rank, suit)
      end
    end

    self.shuffle if options[:shuffled]
  end

  def draw
    @cards.pop
  end

  def shuffle
    @cards.shuffle!

    self
  end
end
