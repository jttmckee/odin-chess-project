require './lib/board.rb'


class Piece
  attr_reader :board, :colour
  attr_accessor :x, :y
  def initialize(x,y,colour,board)
    @x=x;@y=y
    @board=board
    self.colour = colour
    @board.new_piece  self
  end

  def colour=(colour)
    if [:white,:black].include? colour
      @colour = colour
    else
      raise ("Colour can only be set to white or black")
    end
  end

  def legal_move?(new_x,new_y)
    @board.in_range?(new_x,new_y) &&
    (@board[new_x,new_y]&.colour != self.colour)
  end
end
