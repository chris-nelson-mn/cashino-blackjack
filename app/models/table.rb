class Table < ApplicationRecord
  has_many :players

  before_create :setup
  before_save :marshall_card_data

  def deal
    players.each { |p| p.hand = @shoe.deal }
    @dealer_hand = @shoe.deal
    players.each { |p| p.hand.add(@shoe.draw) }
    @dealer_hand.add(@shoe.draw)

    self
  end

  def dealer_hand
    @dealer_hand ||= begin
      return nil if dealer_hand_data.nil?

      cards = dealer_hand_data.map { |c| Card.from_parsed_json(c) }
      Hand.new(cards)
    end
  end

  def shoe
    @shoe ||= begin
      return nil if shoe_data.nil?

      Deck.from_parsed_json(shoe_data)
    end
  end

  private

  def setup
    self.active_player = 0
    @shoe = Deck.new(shuffled: true)
  end

  def marshall_card_data
    self.dealer_hand_data = dealer_hand.cards.to_json if dealer_hand
    self.shoe_data = shoe.to_json if shoe
  end
end
