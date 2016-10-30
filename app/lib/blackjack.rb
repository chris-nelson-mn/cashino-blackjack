class Blackjack
  class << self
    def score(hand, options={})
      options.reverse_merge!({ aces: :best })
      aces_high = options[:aces] == :high

      score = hand.cards.map { |card| value_for(card, aces_high) }.sum

      if options[:aces] == :best
        aces_in_hand = hand.cards.detect { |c| c.rank == :ace }.present?
        score += 10 if aces_in_hand && score < 12
      end

      score
    end

    def busted?(hand)
      score(hand) > 21
    end

    private

    def value_for(card, aces_high)
      case card.rank
      when :ace
        aces_high ? 11 : 1
      when :two
        2
      when :three
        3
      when :four
        4
      when :five
        5
      when :six
        6
      when :seven
        7
      when :eight
        8
      when :nine
        9
      when :ten, :jack, :queen, :king
        10
      else
        fail "#{card.rank} is not a legal card rank in Blackjack"
      end
    end
  end

  def initialize(deck)
    @deck = deck
  end

  def deal
    @deck.draw
  end
end
