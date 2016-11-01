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

  describe '#==' do
    let(:card1) { Card.new(:ace, :spades) }
    let(:card2) { Card.new(:two, :spades) }
    let(:hand) { Hand.new([card1]) }

    context 'with the same number and type of cards' do
      let(:other_hand) { Hand.new([card1.dup]) }

      it { expect(hand == other_hand).to be true }
    end

    context 'with the same size but different cards' do
      let(:other_hand) { Hand.new([card2]) }

      it { expect(hand == other_hand).to be false }
    end

    context 'with different sizes' do
      let(:other_hand) { Hand.new([card1.dup, card2]) }

      it { expect(hand == other_hand).to be false }
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

  describe "#split" do
    let(:ace)       { Card.new(:ace, :spades) }
    let(:other_ace) { Card.new(:ace, :hearts) }
    let(:two)       { Card.new(:two, :spades) }
    let(:three)     { Card.new(:three, :spades) }

    context 'a hand of 2 cards of the same rank' do
      let(:hand) { Hand.new [ace, other_ace] }

      it { expect(hand.split).to eq([Hand.new([ace]), Hand.new([other_ace])]) }
    end

    context 'a hand of 2 different rank cards' do
      let(:hand) { Hand.new [ace, two] }

      it { expect { hand.split }.to raise_exception(PlayError) }
    end

    context 'a hand of 3 cards' do
      let(:hand) { Hand.new [ace, two, three] }

      it { expect { hand.split }.to raise_exception(PlayError) }
    end

    context 'a hand of 1 card' do
      let(:hand) { Hand.new [ace] }

      it { expect { hand.split }.to raise_exception(PlayError) }
    end
  end

  describe "#splittable?" do
    subject { hand.splittable? }

    let(:ace)       { Card.new(:ace, :spades) }
    let(:other_ace) { Card.new(:ace, :hearts) }
    let(:two)       { Card.new(:two, :spades) }
    let(:three)     { Card.new(:three, :spades) }

    context 'a hand of 2 different rank cards' do
      let(:hand) { Hand.new [ace, two] }

      it { is_expected.to be false }
    end

    context 'a hand of 2 cards of the same rank' do
      let(:hand) { Hand.new [ace, other_ace] }

      it { is_expected.to be true }
    end

    context 'a hand of 3 cards' do
      let(:hand) { Hand.new [ace, two, three] }

      it { is_expected.to be false }
    end

    context 'a hand of 1 card' do
      let(:hand) { Hand.new [ace] }

      it { is_expected.to be false }
    end
  end
end
