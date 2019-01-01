require './lib/knight.rb'


RSpec.describe Knight do
  subject(:knight){ Knight.new(:b,2,:black,Board.new) }
  describe "#legal_move?" do
    it "returns true if legal move" do
      expect(knight.legal_move?(:c,4)).to be true
    end
    it "returns false if not permitted Knight move(y)" do
      expect(knight.legal_move?(:c,6)).to be false
    end
    it "returns false if not permitted Knight move(x)" do
      expect(knight.legal_move?(:h,4)).to be false
    end
    #check inheriting from piece
    let(:new_piece) {new_piece = Piece.new(:c,5,:black,subject.board) }
    include_examples "allowed move"
  end

  include_examples "set colour"

  include_examples "#new"
  include_examples "moved"
  let(:white) {'♘'} ; let(:black) {'♞'}
  include_examples "display"

end
