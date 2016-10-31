class Hand
  attr_reader :cards

  def initialize(cards=nil)
    @cards = cards || []
  end

  def add(card)
    @cards << card

    self
  end

  def ==(other_hand)
    @cards == other_hand.cards
  end

  def split
    fail PlayError, "Can't split a hand of more than 2 cards" if @cards.length != 2

    [Hand.new([@cards.first]), Hand.new([@cards.last])]
  end

  def splittable?
    @cards.length == 2
  end
end
