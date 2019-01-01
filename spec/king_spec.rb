require './lib/king.rb'

RSpec.describe King do
  subject(:king){ King.new(:b,2,:black,Board.new )}
  describe "#legal_move?" do
    it "returns true if legal move" do
      expect(subject.legal_move?(:c,2)).to be true
    end
    it "returns false if not permitted King move(y)" do
      expect(subject.legal_move?(:b,6)).to be false
    end
    it "returns false if not permitted King move(x)" do
      expect(subject.legal_move?(:h,2)).to be false
    end
    #check inheriting from piece
    #Set new_piece to where a legal move would be
    let(:new_piece) {new_piece = Piece.new(:b,3,:black,subject.board) }
    include_examples "allowed move"

    let(:pawn) {new_pawn = Pawn.new(:b,5,:white,subject.board)}
    let(:knight) {new_knight = Knight.new(:b,4,:white,subject.board)}

    it "returns false if moving into Check" do
      subject.board.new_piece pawn;subject.board.new_piece knight;
      expect(subject.legal_move?(:c,2)).to be false
    end

    it "returns true if legal move not moving into Check" do
      subject.board.new_piece pawn;subject.board.new_piece knight;
      expect(subject.legal_move?(:c,3)).to be true
    end

    #Castling
    let(:new_king) {King.new(:e,1,:white,Board.new)}
    let(:rook1) {Rook.new(:a,1,:white,new_king.board)}
    let(:rook2) {Rook.new(:h,1,:white,new_king.board)}


    it "returns true for a legal long castling move" do
      rook1
      expect(new_king.legal_move?(:c,1)).to be true
    end
    it "returns true for a legal short castling move" do
      rook2
      expect(new_king.legal_move?(:g,1)).to be true
    end
    it "returns true even if the rook passes through an attacked square" do
      rook3 = Rook.new(:b,6,:black,new_king.board)
      rook1
      expect(new_king.legal_move?(:c,1)).to be true
    end
    it "returns false for an illegal castle (x)" do
      rook1
      expect(new_king.legal_move?(:b,1)).to be false
    end
    it "returns false for an illegal castle (y)" do
      rook2
      expect(new_king.legal_move?(:g,2)).to be false
    end
    it "returns false if there is a same colour piece in the way" do
      rook1
      rook3 = Rook.new(:d,1,:white,new_king.board)
      expect(new_king.legal_move?(:c,1)).to be false
    end
    it "returns false if there is a different colour piece in the way" do
      rook1
      rook3 = Rook.new(:d,1,:black,new_king.board)
      expect(new_king.legal_move?(:c,1)).to be false
    end
    it "returns false if there is a diff colour piece in the way of rook" do
      rook1
      rook3 = Rook.new(:b,1,:black,new_king.board)
      expect(new_king.legal_move?(:c,1)).to be false
    end
    it "returns false if the King passes through check" do
      rook1
      rook3 = Rook.new(:d,6,:black,new_king.board)
      expect(new_king.legal_move?(:c,1)).to be false
    end
    it "returns false if the King is in check" do
      rook1
      rook3 = Rook.new(:e,6,:black,new_king.board)
      expect(new_king.legal_move?(:c,1)).to be false
    end
    it "returns false if rook has been moved" do
      rook1.move(:b,1);rook1.move(:a,1)
      expect(new_king.legal_move?(:c,1)).to be false
    end
    it "returns false if there is no rook without erroring" do
      rook1.move(:b,1)
      expect(new_king.legal_move?(:c,1)).to be false
    end
    it "returns false if the King has been moved" do
      rook2
      new_king.move(:e,2);new_king.move(:e,1)
      expect(new_king.legal_move?(:g,1)).to be false
    end
    it "actually moves the King and Rook (long)" do
      rook1
      new_king.move(:c,1)
      expect(new_king.x).to eq :c
      expect(rook1.x).to eq :d
    end
    it "actually moves the King and Rook (short)" do
      rook2
      new_king.move(:g,1)
      expect(new_king.x).to eq :g
      expect(rook2.x).to eq :f
    end

  end

  subject(:king){ King.new(:b,2,:black,Board.new) }
  include_examples "set colour"
  include_examples "#new"
  include_examples "moved"
  let(:white) {'♔'} ; let(:black) {'♚'}
  include_examples "display"

end
