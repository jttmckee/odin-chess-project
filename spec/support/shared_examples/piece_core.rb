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
