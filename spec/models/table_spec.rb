require 'rails_helper'

RSpec.describe Table, type: :model do
  describe '#dealer' do
    let(:table) { Table.new }

    it 'should return a Dealer' do
      expect(table.dealer).to be_a(Dealer)
    end
  end
end
