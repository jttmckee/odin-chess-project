require './lib/knight.rb'


RSpec.describe Knight do
  subject(:knight){ Knight.new(:b,2,:black,Board.new(8)) }
  describe "#legal_move?" do
    it "returns true if legal move" do
      expect(knight.legal_move?(:c,5)).to be true
    end
    it "returns false if not permitted Knight move(y)" do
      expect(knight.legal_move?(:c,6)).to be false
    end
    it "returns false if not permitted Knight move(x)" do
      expect(knight.legal_move?(:h,5)).to be false
    end
    #check inheriting from piece
    let(:new_piece) {new_piece = Piece.new(:c,5,:black,subject.board) }
    include_examples "allowed move"
  end

  subject(:knight){ Knight.new(:b,2,:black,Board.new(8)) }
  include_examples "set colour"

end
