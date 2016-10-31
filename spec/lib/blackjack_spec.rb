require 'rails_helper'

RSpec.describe Blackjack do
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
      let(:one_ace_hand) { Hand.new [Card.new(:ace, :clubs), Card.new(:five, :diamonds)] }
      let(:two_ace_hand) { Hand.new [Card.new(:ace, :spades), Card.new(:ace, :clubs), Card.new(:five, :diamonds)] }

      context 'with default treatment of aces (best hand)' do
        it { expect(Blackjack.score(one_ace_hand)).to eq(16) }
        it { expect(Blackjack.score(two_ace_hand)).to eq(17) }
      end

      context 'with aces scored to make the best hand' do
        let(:busted_ace_hand) { Hand.new [Card.new(:ace, :clubs), Card.new(:seven, :diamonds), Card.new(:five, :clubs), Card.new(:ten, :clubs)] }

        it { expect(Blackjack.score(one_ace_hand, aces: :best)).to eq(16) }
        it { expect(Blackjack.score(two_ace_hand, aces: :best)).to eq(17) }
        it { expect(Blackjack.score(busted_ace_hand, aces: :best)).to eq(23) }
      end

      context 'with aces treated as 1' do
        it { expect(Blackjack.score(one_ace_hand, aces: :low)).to eq(6) }
        it { expect(Blackjack.score(two_ace_hand, aces: :low)).to eq(7) }
      end

      context 'with aces treated as 11' do
        it { expect(Blackjack.score(one_ace_hand, aces: :high)).to eq(16) }
        it { expect(Blackjack.score(two_ace_hand, aces: :high)).to eq(27) }
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

  describe '.result' do
    subject { Blackjack.result(player_hand, dealer_hand) }

    context 'where the player has a higher hand than the dealer and neither busted' do
      let(:player_hand) { Hand.new [Card.new(:ten, :diamonds), Card.new(:nine, :clubs)] }
      let(:dealer_hand) { Hand.new [Card.new(:ten, :spades), Card.new(:eight, :clubs)] }

      it { is_expected.to eq(:win) }
    end

    context 'where the player has a lower hand than the dealer and neither busted' do
      let(:player_hand) { Hand.new [Card.new(:ten, :diamonds), Card.new(:seven, :clubs)] }
      let(:dealer_hand) { Hand.new [Card.new(:ten, :spades), Card.new(:queen, :clubs)] }

      it { is_expected.to eq(:loss) }
    end

    context 'where the player busted' do
      let(:player_hand) { Hand.new [Card.new(:ten, :diamonds), Card.new(:four, :clubs), Card.new(:king, :clubs)] }
      let(:dealer_hand) { Hand.new [Card.new(:ten, :spades), Card.new(:queen, :clubs)] }

      it { is_expected.to eq(:loss) }
    end

    context 'where the dealer busted and the player did not' do
      let(:player_hand) { Hand.new [Card.new(:ten, :diamonds), Card.new(:seven, :clubs)] }
      let(:dealer_hand) { Hand.new [Card.new(:ten, :spades), Card.new(:five, :clubs), Card.new(:seven, :hearts)] }

      it { is_expected.to eq(:win) }
    end

    context 'where both player and dealer busted' do
      let(:player_hand) { Hand.new [Card.new(:ten, :diamonds), Card.new(:four, :clubs), Card.new(:king, :clubs)] }
      let(:dealer_hand) { Hand.new [Card.new(:ten, :spades), Card.new(:five, :clubs), Card.new(:seven, :hearts)] }

      it { is_expected.to eq(:loss) }
    end

    context 'where the player and dealer hit the same total' do
      let(:player_hand) { Hand.new [Card.new(:ten, :diamonds), Card.new(:seven, :clubs)] }
      let(:dealer_hand) { Hand.new [Card.new(:ten, :spades), Card.new(:seven, :spades)] }

      it { is_expected.to eq(:push) }
    end
  end
end
