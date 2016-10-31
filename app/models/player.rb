class Player < ApplicationRecord
  belongs_to :table

  attr_reader :hands

  def hands=(hands)
    self.update(active_hand: 0)
    @hands = hands
  end

  def hand
    @hands[active_hand]
  end

  def hand=(hand)
    @hands = [hand]
  end

  def next_hand
    self.update(active_hand: active_hand + 1)
    hand
  end
end
