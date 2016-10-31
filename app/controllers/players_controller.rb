class PlayersController < ApplicationController
  before_action :set_player, only: [:hit, :split]

  def hit
    table = @player.table
    hand = params[:hand] ? @player.hands[params[:hand].to_i] : @player.hand
    hand.add(table.shoe.draw)

    @player.save
    table.save

    redirect_to table_path(table)
  end

  def split
    @player.hands = @player.hand.split
    @player.hands.each { |h| h.add(@player.table.shoe.draw) }

    @player.save
    @player.table.save

    redirect_to table_path(@player.table)
  end

  private
    def set_player
      @player = Player.find(params[:id])
    end
end
