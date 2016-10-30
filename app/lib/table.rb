class Table
  attr_reader :players, :dealer

  def initialize
    @players = []
    @dealer = Dealer.new
  end

  def add_player(player)
    @players << player
  end
end
