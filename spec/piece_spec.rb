require './lib/piece.rb'
RSpec.describe Piece, shared: true do
  subject(:piece) { Piece.new(2,2,:white,Board.new(8)) }
  describe "#legal_move?" do
    include_examples "move in range"
  end

  include_examples "set colour"


end
