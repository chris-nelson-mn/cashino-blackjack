require 'rails_helper'

RSpec.describe Player do

  describe '.new' do
    it 'returns a Player instance' do
      expect(Player.new).to be_a(Player)
    end
  end

  it { is_expected.to have_attr_accessor_for(:bet) }
  it { is_expected.to have_attr_accessor_for(:hands) }

  describe '#next_hand' do
    let(:deck) { Deck.new(shuffled: true) }

    context 'for a player with one hand' do
      let(:player) { Player.new.tap { |p| p.hands = [deck.deal(2)] } }

      it { expect(player.next_hand).to be nil }
    end

    context 'for a player with multiple hands' do
      let(:player) { Player.new.tap { |p| p.hands = [deck.deal(2), deck.deal(2)] } }

      context 'when the first hand is active' do
        it { expect(player.next_hand).to eq(player.hands[1]) }
      end

      context 'when the second hand is active' do
        before { player.next_hand }

        it { expect(player.next_hand).to be nil }
      end
    end
  end

  describe '#hand' do
    let(:deck) { Deck.new(shuffled: true) }

    context 'for a player with one hand' do
      let(:player) { Player.new.tap { |p| p.hands = [deck.deal(2)] } }

      it 'returns the hand' do
        expect(player.hand).to eq(player.hands.first)
      end
    end

    context 'for a player with multiple hands' do
      let(:player) { Player.new.tap { |p| p.hands = [deck.deal(2), deck.deal(2)] } }

      context 'when the first hand is active' do
        it { expect(player.hand).to eq(player.hands.first) }
      end

      context 'when the second hand is active' do
        before { player.next_hand }

        it { expect(player.hand).to eq(player.hands[1]) }
      end
    end
  end

  describe '#hands' do
    let(:player) { Player.new }
    let(:deck) { Deck.new(shuffled: true) }

    context 'when the player has one hand' do

    end

    context 'when the player is playing multiple hands (e.g. they split their hand)' do

    end
  end
end
