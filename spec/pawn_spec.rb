require './lib/pawn.rb'
RSpec.describe Pawn do
  subject(:pawn){ Pawn.new(:b,2,:white,Board.new) }
  describe "#legal_move?" do
    it "returns true if legal move (move one)" do
      expect(subject.legal_move?(:b,3)).to be true
    end
    it "returns true if legal move (move two at start)" do
      expect(subject.legal_move?(:b,4)).to be true
    end
    it "returns false if not permitted move(y)" do
      expect(subject.legal_move?(:b,1)).to be false
    end
    it "returns false if not permitted move(x)" do
      expect(subject.legal_move?(:a,3)).to be false
    end

    let(:pawn2){ Pawn.new(:b,4,:black,Board.new) }
    it "doesn't allow two moves not at start" do
      expect(subject.legal_move?(:b,2)).to eq false
    end
    let(:piece_a){Piece.new(:a,3,:black,subject.board)}
    let(:piece_b){Piece.new(:b,3,:black,subject.board)}
    it "allows diagonal taking move" do
      pawn2.board.new_piece piece_a
      expect(subject.legal_move?(:a,3)).to eq true
    end
    it "doesn't allow forward taking move" do
      pawn2.board.new_piece piece_a
      pawn2.board.new_piece piece_b
      expect(subject.legal_move?(:b,3)).to eq false
    end
    #check inheriting from piece
    #Set new_piece to where a legal move would be
    let(:new_piece) {new_piece = Piece.new(:b,5,:black,subject.board) }
    include_examples "allowed move"
  end

  include_examples "set colour"
  include_examples "#new"
  let(:white) {'♙'} ; let(:black) {'♟'}
  include_examples "display"
end
