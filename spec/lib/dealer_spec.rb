require 'rails_helper'

RSpec.describe Dealer do
  it { is_expected.to be_a_kind_of(Player) }

  describe '.new' do
    it { expect(Dealer.new).to be_a(Dealer) }
  end
end
