require './lib/queen.rb'

RSpec.describe Queen do
  subject(:queen){ Queen.new(:b,2,:black,Board.new )}
  describe "#legal_move?" do
    it "returns true if legal diagonal move" do
      expect(subject.legal_move?(:c,3)).to be true
    end
    it "returns true if legal linear move" do
      expect(subject.legal_move?(:b,5)).to be true
    end
    it "returns false if not permitted Queen move" do
      expect(subject.legal_move?(:d,6)).to be false
    end
    #check inheriting from piece
    #Set new_piece to where a legal move would be
    let(:new_piece) {new_piece = Piece.new(:b,3,:black,subject.board) }
    include_examples "allowed move"
    include_examples "diagonal moves"
    include_examples "linear moves"

  end

  subject(:queen){ Queen.new(:b,2,:black,Board.new) }
  include_examples "set colour"
  include_examples "#new"
  include_examples "moved"
  let(:white) {'♕'} ; let(:black) {'♛'}
  include_examples "display"

end
