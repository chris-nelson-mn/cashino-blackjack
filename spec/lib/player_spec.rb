require 'rails_helper'

RSpec.describe Player do

  describe '.new' do
    it 'returns a Player instance' do
      expect(Player.new).to be_a(Player)
    end
  end

  describe '#hand=' do
    let(:deck) { Deck.new }
    let(:hand) { Hand.new(deck, 2) }
    let(:player) { Player.new }

    it 'sets and returns the Hand' do
      expect(player.hand = hand).to eq(hand)
    end
  end

  describe '#hand' do
    let(:deck) { Deck.new }
    let(:hand) { Hand.new(deck, 2) }
    let(:player) { Player.new }

    context 'when a hand has been set' do
      before { player.hand = hand }

      it 'gets the hand that was set' do
        expect(player.hand).to eq(hand)
      end
    end

    context 'when no hand has been set' do
      it { expect(player.hand).to be_nil }
    end
  end
end
