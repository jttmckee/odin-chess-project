require './lib/board.rb'
RSpec.describe "Board" do
  subject(:board) {Board.new(8)}
  describe "#new_piece" do
    it "creates a new piece" do
      piece = Piece.new(1,1,:white,board)
      expect(board.new_piece= piece).to be true
    end
    it "fails if a piece is already there" do
      old_piece = Piece.new(1,1,:black,board)
      piece = Piece.new(1,1,:white,board)
      expect(board.new_piece= piece).to be false
      expect(board[1,1]).to eql(old_piece)
    end
  end
  describe "[]" do
    it "pulls the piece at that location" do
      piece = Piece.new(1,1,:white,board)
      board.new_piece= piece
      expect(board[1,1]).to eql(piece)
    end

  end


end
