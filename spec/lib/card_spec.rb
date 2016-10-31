require 'rails_helper'

RSpec.describe Card do
  subject { Card.new(:ace, :spades) }

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

  describe '#==' do
    let(:ace_spades) { Card.new(:ace, :spades) }
    let(:other_ace_spades) { Card.new(:ace, :spades) }
    let(:ace_hearts) { Card.new(:ace, :hearts) }
    let(:seven_spades) { Card.new(:seven, :spades) }

    it { expect(ace_spades == ace_spades).to be true }
    it { expect(ace_spades == other_ace_spades).to be true }
    it { expect(ace_spades == ace_hearts).to be false }
    it { expect(ace_spades == seven_spades).to be false }
  end

  describe '#to_s' do
    it do
      expect(subject.to_s).to eq('ace of spades')
    end
  end
end
