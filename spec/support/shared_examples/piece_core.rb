RSpec.shared_examples "core Piece" do
  context "false when outside of board range" do
    it  "(-x)" do
      expect(subject.legal_move?(-1,1)).to be false
    end
    it "(-y)" do
      expect(subject.legal_move?(1,-1)).to be false
    end
    it "(x=100)" do
     expect(subject.legal_move?(100,1)).to be false
    end
    it "(y=100)" do
      expect(subject.legal_move?(1,100)).to be false
    end
  end

end
