require './lib/piece.rb'
RSpec.describe Piece, shared: true do
  subject(:piece) { Piece.new(2,2,:white,Board.new(8)) }
  describe "#legal_move?" do
    let(:new_piece) {new_piece = Piece.new(2,3,:white,subject.board) }
    include_examples "allowed move"
  end

  include_examples "set colour"


end
