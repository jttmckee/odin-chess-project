require './lib/piece.rb'
RSpec.describe Piece do
  describe "#legal_move?" do
    it "returns false if move outside range of board" do
      piece = Piece.new(2,2,Board.new(8))
      expect(piece.legal_move?(-1,2)).to eql(false)
    end
  end


end
