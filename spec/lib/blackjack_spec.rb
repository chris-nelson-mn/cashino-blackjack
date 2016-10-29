require 'rails_helper'

RSpec.describe Blackjack do

  describe '.new' do
    let(:deck) { Deck.new }
    it 'takes a deck, returns a Blackjack instance' do
      expect(Blackjack.new(deck)).to be_a(Blackjack)
    end
  end

  describe '#add_player' do
    let(:deck) { Deck.new }
    let(:blackjack) { Blackjack.new(deck) }
    let(:player) { Player.new }

    context 'with no other players' do
      it 'returns an array with that player' do
        expect(blackjack.add_player(player)).to eq([player])
      end
    end

    context 'with a player already added' do
      let(:existing_player) { Player.new }

      before { blackjack.add_player(existing_player) }

      it 'returns an array with both players' do
        expect(blackjack.add_player(player)).to eq([existing_player, player])
      end
    end
  end

  describe '#players' do
    let(:deck) { Deck.new }
    let(:blackjack) { Blackjack.new(deck) }

    context 'with no players' do
      it { expect(blackjack.players).to eq([]) }
    end

    context 'with a player added' do
      let(:player) { Player.new }

      before { blackjack.add_player(player) }

      it { expect(blackjack.players).to eq([player]) }
    end
  end
end
