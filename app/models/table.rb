class Table < ApplicationRecord
  has_many :players

  before_create :setup
  before_save :marshall_card_data

  def deal
    # Deal cards in 2 passes, as would be done live
    hands = Array.new(players.count + 1)
    hands.map! { @shoe.deal }
    hands.each { |h| h.add(@shoe.draw) }

    players.each_with_index { |p, i| p.hand = hands[i] }
    @dealer_hand = hands.last

    self
  end

  def dealer_hand
    @dealer_hand ||= begin
      return nil if dealer_hand_data.nil?

      cards = JSON.parse(dealer_hand_data).map { |c| Card.from_parsed_json(c) }
      Hand.new(cards)
    end
  end

  def shoe
    @shoe ||= begin
      return nil if shoe_data.nil?

      Deck.from_parsed_json(JSON.parse(shoe_data))
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
