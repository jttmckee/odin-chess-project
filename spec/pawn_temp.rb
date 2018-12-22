require './lib/pawn.rb'
#NEED TO ADD DIRECTION!
#DIRECTION IS KEY FOR PAWN
#OR DERIVE DIRECTION FROM HOME
RSpec.describe Pawn do
  subject(:pawn){ Pawn.new(:b,2,:black,Board.new(8)) }
  describe "#legal_move?" do
    it "returns true if legal move (move one)" do
      expect(subject.legal_move?(:b,3)).to be true
    end
    it "returns true if legal move (move two at start)" do
      expect(subject.legal_move?(:b,4)).to be true
    end
    it "returns false if not permitted move(y)" do
      expect(subject.legal_move?(:b,7)).to be false
    end
    it "returns false if not permitted move(x)" do
      expect(subject.legal_move?(:h,2)).to be false
    end
    subject(:pawn){ Pawn.new(:b,4,:black,Board.new(8)) }
    let(:piece_a){Piece.new(:a,5,:white,subject.board)}
    let(:piece_b){Piece.new(:b,)}
    #check inheriting from piece
    #Set new_piece to where a legal move would be
    let(:new_piece) {new_piece = Piece.new(:b,3,:black,subject.board) }
    include_examples "allowed move"
  end

  subject(:pawn){ Pawn.new(:b,2,:black,Board.new(8)) }
  include_examples "set colour"
  include_examples "#new"


end
