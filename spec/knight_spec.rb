require './lib/knight.rb'


RSpec.describe Knight do
  describe "#legal_move?" do
    subject(:knight){ Knight.new(2,2,:black,Board.new(8)) }
    it "returns true if legal move" do
      expect(knight.legal_move?(3,5)).to be true
    end
    it "returns false if not permitted Knight move(y)" do
      expect(knight.legal_move?(3,6)).to be false
    end
    it "returns false if not permitted Knight move(x)" do
      expect(knight.legal_move?(8,5)).to be false
    end
    #check inheriting from piece
    include_examples "move in range"

  end
end
