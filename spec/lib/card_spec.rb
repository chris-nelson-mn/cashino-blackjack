require 'rails_helper'

RSpec.describe Card do
  subject { Card.new(:spades, :ace) }

  describe '#suit' do
    it 'returns the correct suit' do
      expect(subject.suit).to eq(:spades)
    end
  end

  describe '#rank' do
    it 'returns the correct rank' do
      expect(subject.rank).to eq(:ace)
    end
  end

  describe '#to_s' do
    it do
      expect(subject.to_s).to eq('ace of spades')
    end
  end
end
