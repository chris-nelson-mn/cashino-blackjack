require 'rails_helper'

RSpec.describe Hand do
  let(:deck) { Deck.new }

  describe '.new' do
    it 'accepts zero arguments and returns a Hand' do
      expect(Hand.new).to be_a(Hand)
    end

    it 'accepts an array of cards and returns a Hand' do
      expect(Hand.new([deck.draw, deck.draw])).to be_a(Hand)
    end
  end

  describe '#cards' do
    let(:dealt_cards) { [deck.draw, deck.draw] }
    let(:hand) { Hand.new(dealt_cards) }

    it 'returns the cards in the hand' do
      expect(hand.cards).to eq(dealt_cards)
    end
  end

  describe '#add' do
    let(:dealt_cards) { [deck.draw, deck.draw] }
    let(:additional_card) { deck.draw }
    let(:hand) { Hand.new(dealt_cards).add(additional_card) }

    it 'returns the hand' do
      expect(hand).to be_a(Hand)
    end
    it 'contains the initial cards plus the one added' do
      expect(hand.cards).to eq(dealt_cards << additional_card)
    end
  end
end
