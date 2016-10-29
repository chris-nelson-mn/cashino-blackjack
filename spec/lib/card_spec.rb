require 'rails_helper'
require 'autoloaded/card'

RSpec.describe Card do
  subject { Card.new('spade', 'ace') }

  it 'returns the correct suit' do
    expect(subject.suit).to eq('spade')
  end

  it 'returns the correct rank' do
    expect(subject.rank).to eq('ace')
  end
end
