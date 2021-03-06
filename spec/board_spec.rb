
require './lib/board.rb'
RSpec.describe "Board" do
  subject(:board) {Board.new}
  describe "#new_piece" do
    it "creates a new piece" do
      expect(board.new_piece Piece.new(:a,1,:white,Board.new)).to be true
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

  describe "#home" do
    let(:white_piece) {Piece.new(:a,4,:white,subject)}
    let(:black_piece) {Piece.new(:b,6,:black,subject)}
    let(:not_used) {board.set_home(white_piece,1)}
    context "correctly returns the home row" do
      it "for a white piece" do
        expect(subject.home(white_piece)).to eql(1)
      end
      it "for a black piece" do
        expect(subject.home(black_piece)).to eql(8)
      end
    end
    it "returns a changed home row" do
      board.set_home(white_piece,8)
      expect(subject.home(black_piece)).to eql(1)
    end

  end

  describe "#pieces" do
    let(:piece1) {Piece.new(:a,2,:black,Board.new)}
    let(:piece2) {Piece.new(:b,3,:white,Board.new)}
    it "returns all the pieces on the board without block" do
      subject.new_piece piece1;subject.new_piece piece2;
      expect(subject.pieces).to eq [piece1,piece2]
    end

    it "returns all the pieces meeting the block condition" do
      subject.new_piece piece1;subject.new_piece piece2;
      expect(subject.pieces{|piece| piece.colour == :white}).to eq [piece2]
    end

  end

  describe "#range_x" do
    it "for default boards returns" do
      expect(subject.range_x).to eql(:h)
    end
    it "returns the maxium symbol range" do
      board = Board.new(9)
      expect(board.range_x).to eql(:i)
    end
  end

  describe "#display" do
    it "displays an empty board" do
      expect{Board.new.display}.to output(<<-BOARD).to_stdout
    a   b   c   d   e   f   g   h
  ┏━━━┳━━━┳━━━┳━━━┳━━━┳━━━┳━━━┳━━━┓
 8┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃8
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 7┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃7
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 6┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃6
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 5┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃5
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 4┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃4
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 3┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃3
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 2┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃2
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 1┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃1
  ┗━━━┻━━━┻━━━┻━━━┻━━━┻━━━┻━━━┻━━━┛
    a   b   c   d   e   f   g   h
      BOARD
    end

    it "displays a board with pieces" do
        expect{
      board = Board.new
      king1 = King.new(:d,7,:white,board)
      king2 = King.new(:f,3,:black,board)
      queen = Queen.new(:h,5,:white,board)
      rook = Rook.new(:a,1,:black,board)
      bishop = Bishop.new(:c,8,:white,board)
      knight = Knight.new(:f,8,:black,board)
      pawn = Pawn.new(:h,3,:white,board)
      board.display}.to output(<<-BOARD).to_stdout
    a   b   c   d   e   f   g   h
  ┏━━━┳━━━┳━━━┳━━━┳━━━┳━━━┳━━━┳━━━┓
 8┃   ┃▌ ▐┃ ♗ ┃▌ ▐┃   ┃▌♞▐┃   ┃▌ ▐┃8
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 7┃▌ ▐┃   ┃▌ ▐┃ ♔ ┃▌ ▐┃   ┃▌ ▐┃   ┃7
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 6┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃6
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 5┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃ ♕ ┃5
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 4┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃4
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 3┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃ ♚ ┃▌ ▐┃ ♙ ┃3
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 2┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃2
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 1┃▌♜▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃1
  ┗━━━┻━━━┻━━━┻━━━┻━━━┻━━━┻━━━┻━━━┛
    a   b   c   d   e   f   g   h
      BOARD
    end
    it "displays a board with pieces after moves" do
        expect{
      board = Board.new
      king1 = King.new(:b,6,:black,board)
      king2 = King.new(:f,2,:white,board)
      queen = Queen.new(:h,5,:white,board)
      rook = Rook.new(:a,1,:black,board)
      bishop = Bishop.new(:c,8,:white,board)
      knight = Knight.new(:e,6,:black,board)
      pawn = Pawn.new(:h,3,:white,board)
      king1.move(:c,6)
      knight.move(:f,8)
      pawn.move(:h,4)
      board.display
      }.to output(<<-BOARD).to_stdout
    a   b   c   d   e   f   g   h
  ┏━━━┳━━━┳━━━┳━━━┳━━━┳━━━┳━━━┳━━━┓
 8┃   ┃▌ ▐┃ ♗ ┃▌ ▐┃   ┃▌♞▐┃   ┃▌ ▐┃8
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 7┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃7
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 6┃   ┃▌ ▐┃ ♚ ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃6
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 5┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃ ♕ ┃5
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 4┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌♙▐┃4
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 3┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃3
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 2┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌♔▐┃   ┃▌ ▐┃2
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 1┃▌♜▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃1
  ┗━━━┻━━━┻━━━┻━━━┻━━━┻━━━┻━━━┻━━━┛
    a   b   c   d   e   f   g   h
      BOARD
    end
  end

end
