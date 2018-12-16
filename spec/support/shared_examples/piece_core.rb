RSpec.shared_examples "core Piece" do
  it "False outside of board range (-x)" do
    expect(subject.legal_move?(-1,1)).to be false
  end
  it "False outside of board range (-y)" do
  expect(subject.legal_move?(1,-1)).to be false
  end
  it "False outside of board range (x=100)" do
   expect(subject.legal_move?(100,1)).to be false
  end
  it "False outside of board range (y=100)" do
  expect(subject.legal_move?(1,100)).to be false
  end


end
