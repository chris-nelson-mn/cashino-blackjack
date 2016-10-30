require 'rails_helper'

RSpec.describe Player do

  describe '.new' do
    it 'returns a Player instance' do
      expect(Player.new).to be_a(Player)
    end
  end

  it { is_expected.to have_attr_accessor_for(:hand) }
  it { is_expected.to have_attr_accessor_for(:bet) }
end
