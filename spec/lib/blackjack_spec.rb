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
end
