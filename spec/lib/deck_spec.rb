require 'rails_helper'

RSpec.describe Deck do
  describe '.new' do
    context 'when initialized with suits and ranks' do
      it 'returns a Deck' do
        expect(Deck.new(Deck::DEFAULT_SUITS, Deck::DEFAULT_RANKS)).to be_a(Deck)
      end
    end

    context 'when called with no parameters' do
      it 'returns a Deck' do
        expect(Deck.new).to be_a(Deck)
      end
    end
  end

  context 'with the default deck' do
    let(:deck) { Deck.new }

    describe '#draw' do
      let(:drawn_card) { deck.draw }

      it 'returns a card, the ace of spades' do
        expect(drawn_card).to be_a(Card)
        expect(drawn_card.suit).to eq(:spades)
        expect(drawn_card.rank).to eq(:ace)
      end
    end

    describe '#shuffle' do
      let(:first_four) { [deck.draw, deck.draw, deck.draw, deck.draw] }

      before do
        deck.shuffle
      end

      it 'reorders the cards' do
        expect(first_four.map(&:to_s).join(', ')).to_not eq("ace of spades, two of spades, three of spades, four of spades")
      end
    end
  end
end
