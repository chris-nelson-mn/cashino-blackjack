require 'rails_helper'

RSpec.describe Table do
  describe '.new' do
    it { expect(Table.new).to be_a(Table) }
  end

  describe '#add_player' do
    let(:table) { Table.new }
    let(:player) { Player.new }

    context 'with no other players' do
      it 'returns an array with that player' do
        expect(table.add_player(player)).to eq([player])
      end
    end

    context 'with a player already added' do
      let(:existing_player) { Player.new }

      before { table.add_player(existing_player) }

      it 'returns an array with both players' do
        expect(table.add_player(player)).to eq([existing_player, player])
      end
    end
  end

  describe '#players' do
    let(:table) { Table.new }

    context 'with no players' do
      it { expect(table.players).to eq([]) }
    end

    context 'with a player added' do
      let(:player) { Player.new }

      before { table.add_player(player) }

      it { expect(table.players).to eq([player]) }
    end
  end
end
