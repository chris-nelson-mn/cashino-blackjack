require 'rails_helper'

RSpec.describe Deck do
  describe '.new' do
    context 'when initialized with suits and ranks' do
      it 'returns a Deck' do
        expect(Deck.new(suits: Deck::DEFAULT_SUITS, ranks: Deck::DEFAULT_RANKS)).to be_a(Deck)
      end
    end

    context 'when called with no parameters' do
      it 'returns a Deck' do
        expect(Deck.new).to be_a(Deck)
      end
    end

    context 'with the shuffled option' do
      let(:new_shuffled_deck) { Deck.new(shuffled: true) }
      let(:first_four) do
        [ new_shuffled_deck.draw, new_shuffled_deck.draw, new_shuffled_deck.draw, new_shuffled_deck.draw ]
      end

      it { expect(new_shuffled_deck).to be_a(Deck) }
      it 'has been shuffled' do
        default_first_four = "ace of spades, two of spades, three of spades, four of spades"
        expect(first_four.map(&:to_s).join(', ')).to_not eq(default_first_four)
      end
    end
  end

  describe '.from_parsed_json' do
    let(:parsed_json) do
      {
        'cards' => [
          {"rank"=>"king", "suit"=>"hearts"}, {"rank"=>"queen", "suit"=>"hearts"}, {"rank"=>"jack", "suit"=>"hearts"}, {"rank"=>"ten", "suit"=>"hearts"}
        ]
      }
    end
    let(:unmarshalled_deck) { Deck.from_parsed_json(parsed_json) }

    it 'returns a Deck' do
      expect(unmarshalled_deck).to be_a(Deck)
    end
    it 'sets the cards in the right order' do
      expect(unmarshalled_deck.draw).to eq(Card.new(:ten, :hearts))
      expect(unmarshalled_deck.draw).to eq(Card.new(:jack, :hearts))
    end
  end

  context 'with the default deck' do
    let(:deck) { Deck.new }

    describe '#draw' do
      let(:drawn_card) { deck.draw }

      context 'with cards remaining' do
        it 'returns a card, the ace of spades' do
          expect(drawn_card).to be_a(Card)
          expect(drawn_card.suit).to eq(:spades)
          expect(drawn_card.rank).to eq(:ace)
        end
      end

      context 'when out of cards' do
        before { deck.size.times { deck.draw } }

        it { expect(drawn_card).to be nil }
      end
    end

    describe '#shuffle' do
      let!(:shuffled_deck) { deck.shuffle }
      let(:first_four) { [deck.draw, deck.draw, deck.draw, deck.draw] }

      it 'returns the deck' do
        expect(shuffled_deck).to eq(deck)
      end
      it 'reorders the cards' do
        default_first_four = "ace of spades, two of spades, three of spades, four of spades"
        expect(first_four.map(&:to_s).join(', ')).to_not eq(default_first_four)
      end
    end

    describe '#deal' do
      let(:deck) { Deck.new }

      it { expect(deck.deal).to be_a(Hand) }

      context 'when there are more cards than the requested hand size' do
        it { expect(deck.deal.size).to eq(1) }
        it { expect(deck.deal(5).size).to eq(5) }
      end

      context 'when there are fewer cards in the deck than the requested hand size' do
        before do
          (deck.size - 2).times { deck.draw }
        end

        it { expect(deck.deal(5).size).to eq(2) }
      end

      context 'when there are no cards in the deck' do
        before do
          deck.size.times { deck.draw }
        end

        it { expect(deck.deal.size).to eq(0) }
      end
    end
  end
end
