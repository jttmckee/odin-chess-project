RSpec.shared_examples "allowed move" do
  context "false when outside of board range" do
    it  "(x=z)" do
      expect(subject.legal_move?(:z,1)).to be false
    end
    it "(-y)" do
      expect(subject.legal_move?(:a,-1)).to be false
    end
    it "(x=m)" do
     expect(subject.legal_move?(:m,1)).to be false
    end
    it "(y=100)" do
      expect(subject.legal_move?(:a,100)).to be false
    end
  end

  context "doesn't allow move if" do
    it "piece of same colour occupies space" do
      expect(subject.legal_move?(new_piece.x,new_piece.y)).to be false
    end
  end
end

  RSpec.shared_examples "diagonal moves" do
    let(:piece) {subject.class.new(:b,3,:white,subject.board)}
    it "can move diagonally when it's clear" do
      expect(piece.legal_move?(:e,6)).to be true
    end
    let(:piece2) {piece.class.new(:c,4,:black,subject.board)}

    it "can't move diagonally when there is a piece on the path" do
      piece2
      expect(piece.legal_move?(:e,6)).to be false
    end
    let(:piece3) { piece.class.new(:c,2,:black,subject.board)}

    it "can move diagonally to take" do
      piece3
      expect(piece.legal_move?(:c,2)).to be true
    end
  end



RSpec.shared_examples "set colour" do
  context "allows colour to be set to" do
    it "white" do
      subject.colour = :white
      expect(subject.colour).to be :white
    end
    it "black" do
      subject.colour = :black
      expect(subject.colour).to be :black
    end
  end
  it "raises error with another colour" do

    expect{ subject.colour = :red }.
    to raise_error "Colour can only be set to white or black"

  end
end

RSpec.shared_examples "#new" do
  context "raises error if for new piece" do
    it "there is already a piece at location" do
      expect {subject.class.new(subject.x,subject.y,:white,subject.board)}.
      to raise_error "Error - there is already a piece at location #{subject.x},#{subject.y}"
    end
  end
end
