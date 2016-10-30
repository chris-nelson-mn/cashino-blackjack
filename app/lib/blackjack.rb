class Blackjack
  class << self
    def score(hand, options={})
      options.reverse_merge({ aces_high: false })

      hand.cards.map { |card| value_for(card, options[:aces_high]) }.sum
    end

    def busted?(hand)
      score(hand, aces_high: false) > 21
    end

    private

    def value_for(card, ace_high)
      case card.rank
      when :ace
        ace_high ? 11 : 1
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
      when :jack, :queen, :king
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
