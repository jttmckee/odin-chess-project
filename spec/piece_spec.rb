require './lib/piece.rb'
RSpec.describe Piece, shared: true do
  describe "#legal_move?" do
    subject(:piece) { Piece.new(2,2,Board.new(8)) }

    include_examples "core Piece"

  end


end
