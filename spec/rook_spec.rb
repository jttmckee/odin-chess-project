require './lib/rook.rb'

RSpec.describe Rook do
  subject(:rook){ Rook.new(:b,2,:black,Board.new )}
  describe "#legal_move?" do
    it "returns true if legal move" do
      expect(subject.legal_move?(:b,7)).to be true
    end
    it "returns true if legal move" do
      expect(subject.legal_move?(:b,7)).to be true
    end
    it "returns false if not permitted Rook move(y)" do
      expect(subject.legal_move?(:c,6)).to be false
    end
    it "returns false if not permitted Rook move(x)" do
      expect(subject.legal_move?(:h,3)).to be false
    end
    #check inheriting from piece
    #Set new_piece to where a legal move would be
    let(:new_piece) {new_piece = Piece.new(:b,3,:black,subject.board) }
    include_examples "allowed move"
    include_examples "linear moves"

  end

  subject(:bishop){ Rook.new(:b,2,:black,Board.new) }
  include_examples "set colour"
  include_examples "#new"

end
