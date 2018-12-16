require './lib/knight.rb'

RSpec.describe Knight do
  describe "#legal_move?" do
    it "returns true if legal move" do
      knight = Knight.new(2,2)
      expect(knight.legal_move?(3,5)).to eql(true)
    end
    it "returns false if not permitted Knight move" do
      knight = Knight.new(1,1)
      expect(knight.legal_move?(3,5)).to eql(false)
    end
    #check inheriting from piece
    it "returns false if outside of range of board" do

    end

  end
end
