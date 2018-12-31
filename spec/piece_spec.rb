require './lib/piece.rb'
RSpec.describe Piece, shared: true do
  subject(:piece) { Piece.new(:b,2,:white,Board.new) }
  describe "#legal_move?" do
    let(:new_piece) {new_piece = Piece.new(:b,3,:white,subject.board) }
    include_examples "allowed move"
    include_examples "diagonal moves"
    include_examples "linear moves"
  end

  include_examples "set colour"
  include_examples "#new"
  include_examples "moved"

  describe "#legal_moves?" do
    let(:start) {[:a,1]}
    let(:some_legal_moves) {[[:a,3],[:b,2]]}
    let(:some_illegal_moves) {[:i,9]}
    include_examples "legal moves"

  end

  describe "home" do
    it "returns the home row of the piece" do
      expect(subject.home).to eq 1
    end
  end

end
