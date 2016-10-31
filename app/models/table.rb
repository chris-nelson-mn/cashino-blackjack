class Table < ApplicationRecord
  has_many :players
  
  attr_reader :dealer

  def initialize
    @dealer = Dealer.new
  end
end
