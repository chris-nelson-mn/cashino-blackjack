class Hand
  attr_reader :cards

  def initialize(cards=nil)
    @cards = cards || []
  end

  def add(card)
    @cards << card

    self
  end
end
