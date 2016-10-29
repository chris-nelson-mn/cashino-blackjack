class Blackjack
  attr_reader :players

  def initialize(deck)
    @players = []
  end

  def add_player(player)
    @players << player
  end
end
