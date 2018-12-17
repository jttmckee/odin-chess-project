require './lib/board.rb'


class Piece
  attr_reader :board, :colour
  attr_accessor :x, :y
  def initialize(x,y,colour,board)
    @x=x;@y=y
    @board=board
    self.colour = colour
  end

  def colour=(colour)
    if [:white,:black].include? colour
      @colour = colour
    else
      raise ("Colour can only be set to white or black")
    end
  end

  def legal_move?(new_x,new_y)
    new_x > 0 && new_x <= @board.range && new_y > 0 and new_y <= @board.range
  end
end
