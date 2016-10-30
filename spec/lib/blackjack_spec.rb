require 'rails_helper'

RSpec.describe Blackjack do

  describe '.new' do
    let(:deck) { Deck.new }

    it 'takes a deck, returns a Blackjack instance' do
      expect(Blackjack.new(deck)).to be_a(Blackjack)
    end
  end

  describe '#deal' do
    let(:deck) { Deck.new }
    let(:blackjack) { Blackjack.new(deck) }

    it 'returns a card' do
      expect(blackjack.deal).to be_a(Card)
    end
  end

  describe '.score' do
    subject { Blackjack.score(hand) }

    context 'with a hand that has numeric cards' do
      let(:hand) { Hand.new [Card.new(:eight, :clubs), Card.new(:five, :clubs)] }

      it { is_expected.to eq(13) }
    end

    context 'with a hand that has face cards and numeric cards' do
      let(:hand) { Hand.new [Card.new(:queen, :clubs), Card.new(:five, :clubs), Card.new(:king, :hearts)] }

      it { is_expected.to eq(25) }
    end

    context 'with a hand that has an ace' do
      let(:hand) { Hand.new [Card.new(:ace, :clubs), Card.new(:five, :diamonds)] }

      context 'with default treatment of aces (scored as 1)' do
        it { expect(Blackjack.score(hand)).to eq(6) }
      end

      context 'with aces treated as 1' do
        it { expect(Blackjack.score(hand, aces_high: false)).to eq(6) }
      end

      context 'with aces treated as 11' do
        it { expect(Blackjack.score(hand, aces_high: true)).to eq(16) }
      end
    end
  end

  describe '.busted?' do
    context 'for a hand valued over 21' do
      let(:hand) { Hand.new [Card.new(:queen, :clubs), Card.new(:five, :clubs), Card.new(:king, :hearts)] }

      it { expect(Blackjack.busted?(hand)).to be true }
    end

    context 'for a hand valued 21' do
      let(:hand) { Hand.new [Card.new(:queen, :clubs), Card.new(:five, :clubs), Card.new(:six, :hearts)] }

      it { expect(Blackjack.busted?(hand)).to be false }
    end

    context 'for a hand valued less than 21' do
      let(:hand) { Hand.new [Card.new(:queen, :clubs), Card.new(:five, :clubs)] }

      it { expect(Blackjack.busted?(hand)).to be false }
    end

    context 'for a hand with an ace that could score as 12 or 22' do
      let(:hand) { Hand.new [Card.new(:six, :clubs), Card.new(:five, :clubs), Card.new(:ace, :hearts)] }

      it { expect(Blackjack.busted?(hand)).to be false }
    end
  end
end
