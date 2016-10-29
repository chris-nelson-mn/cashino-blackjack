require 'rails_helper'

RSpec.describe Hand do
  let(:deck) { Deck.new }

  describe '.new' do
    let(:hand_size) { 2 }
    let(:hand) { Hand.new(deck, hand_size) }

    it 'takes a deck and hand size, returns a Hand' do
      expect(hand).to be_a(Hand)
    end
  end

  describe '#cards' do
    let(:hand_size) { 2 }
    let(:hand) { Hand.new(deck, hand_size) }

    it 'returns the cards in the hand' do
      expect(hand.cards.first).to be_a(Card) 
    end
    it 'contains the number of cards specified' do
      expect(hand.cards.length).to eq(hand_size)
    end
  end
end
