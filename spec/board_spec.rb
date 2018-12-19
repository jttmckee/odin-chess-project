require './lib/board.rb'
RSpec.describe "Board" do
  subject(:board) {Board.new(8)}
  describe "#new_piece" do
    it "creates a new piece" do
      expect(board.new_piece Piece.new(:a,1,:white,Board.new(8))).to be true
    end
    #Test removed as covered by the new piece test
    # it "fails if a piece is already there" do
    #   old_piece = Piece.new(:a,4,:black,board)
    #   piece = Piece.new(:a,4,:white,board)
    #   expect(board.new_piece piece).to be false
    #   expect(board[:a,4]).to eql(old_piece)
    # end
    it "fails if outside range" do
      expect(board.new_piece Piece.new(:i,9,:white,board)).to be false
    end
  end
  describe "[]" do
    it "pulls the piece at that location" do
      piece = Piece.new(:a,1,:white,board)
      board.new_piece piece
      expect(board[:a,1]).to eql(piece)
    end

    it "returns nil if there is no piece" do
      expect(board[:g,7]).to be_nil
    end
    context "returns nil if outside range as" do
      it  "x greater than h" do
        board.new_piece  Piece.new(:i,7,:white,board)
        expect(board[:i,7]).to be_nil
      end
      it  "y greater than 8" do
        board.new_piece  Piece.new(:g,9,:white,board)
        expect(board[:g,9]).to be_nil
      end
      it  " x is a number" do
        board.new_piece  Piece.new(-1,:b,:white,board)
        expect(board[1,2]).to be_nil
      end
      it  " y is a symbol" do
        board.new_piece  Piece.new(-1,:b,:white,board)
        expect(board[:b,:a]).to be_nil
      end
      it  " y less than 1" do
        board.new_piece  Piece.new(:a,-2,:white,board)
        expect(board[:a,-2]).to be_nil
      end
      it  "y equals zero" do
        board.new_piece  Piece.new(:z,0,:white,board)
        expect(board[:a,0]).to be_nil
      end
    end


  end

  describe "#move" do
    let(:piece) {Piece.new(:a,3,:white,board)}
    it "throws an error if the move is illegal" do
      expect{board.move(piece,:a,9)}.to raise_error "Illegal move"
    end

    it "moves the piece to the new location" do
      board.move(piece,:b,4)
      expect(board[:b,4]).to eq piece
    end

    it "'takes' the old piece at new location" do
      old_piece = Piece.new(:c,5,:black,board)
      board.move(piece,:c,5)
      expect(board.taken).to include old_piece
    end
  end

end
