require 'rails_helper'

RSpec.describe Deck do
  let(:deck) { Deck.new(Deck::DEFAULT_SUITS, Deck::DEFAULT_RANKS) }

  describe '.new' do
    it 'returns a Deck when initialized with a set of suits and ranks' do
      expect(deck).to be_a(Deck)
    end
  end

  describe '#draw' do
    let(:drawn_card) { deck.draw }
    it 'returns a card, the ace of spades' do
      expect(drawn_card).to be_a(Card)
      expect(drawn_card.suit).to eq('spades')
      expect(drawn_card.rank).to eq('ace')
    end
  end

  describe '#shuffle' do
    let(:drawn_card) { deck.draw }
    before do
      deck.shuffle
    end

    it 'reorders the cards' do
      expect("#{drawn_card.rank} of #{drawn_card.suit}").to_not eq("ace of spades")
    end
  end
end
