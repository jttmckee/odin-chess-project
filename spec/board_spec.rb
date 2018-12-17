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
    it "fails if outside range" do
      piece = Piece.new(9,9,:white,board)
      expect(board.new_piece= piece).to be false
    end
  end
  describe "[]" do
    it "pulls the piece at that location" do
      piece = Piece.new(1,1,:white,board)
      board.new_piece= piece
      expect(board[1,1]).to eql(piece)
    end

    it "returns nil if there is no piece" do
      expect(board[7,7]).to be_nil
    end
    context "returns nil if outside range as" do
      it  "x greater than 8" do
        board.new_piece = Piece.new(9,7,:white,board)
        expect(board[9,7]).to be_nil
      end
      it  "y greater than 8" do
        board.new_piece = Piece.new(7,9,:white,board)
        expect(board[7,9]).to be_nil
      end
      it  " x less than 1" do
        board.new_piece = Piece.new(-1,2,:white,board)
        expect(board[-1,2]).to be_nil
      end
      it  " y less than 1" do
        board.new_piece = Piece.new(1,-2,:white,board)
        expect(board[1,-2]).to be_nil
      end
      it  " equals zero" do
        board.new_piece = Piece.new(0,0,:white,board)
        expect(board[0,0]).to be_nil
      end
    end


  end


end
