require './lib/king.rb'

RSpec.describe King do
  subject(:king){ Knight.new(:b,2,:black,Board.new(8)) }
  describe "#legal_move?" do
    it "returns true if legal move" do
      expect(subject.legal_move?(:c,2)).to be true
    end
    it "returns false if not permitted King move(y)" do
      expect(subject.legal_move?(:b,6)).to be false
    end
    it "returns false if not permitted Knight move(x)" do
      expect(subject.legal_move?(:h,2)).to be false
    end
    #check inheriting from piece
    #Set new_piece to where a legal move would be
    let(:new_piece) {new_piece = Piece.new(:b,3,:black,subject.board) }
    include_examples "allowed move"
  end

  subject(:king){ King.new(:b,2,:black,Board.new(8)) }
  include_examples "set colour"
  include_examples "#new"
end
