class Card
  attr_reader :suit, :rank

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def ==(other_card)
    @rank == other_card.rank && @suit == other_card.suit
  end

  def to_s
    "#{rank} of #{suit}"
  end
end
