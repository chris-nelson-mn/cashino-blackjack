class Player < ApplicationRecord
  belongs_to :table

  attr_reader :hands

  def initialize
    @hands = []
    active_hand = 0
  end

  def hands=(hands)
    @hands = hands
    @active_hand = 0
  end

  def hand
    @hands[@active_hand]
  end

  def hand=(hand)
    self.hands = [hand]
  end

  def next_hand
    @active_hand += 1
    hand
  end
end
