require './lib/board.rb'


class Piece
  attr_reader :board
  attr_accessor :x, :y
  def initialize(x,y,board)
    @x=x;@y=y;@board=board
  end

  def legal_move?(new_x,new_y)
    new_x > 0 && new_x <= @board.range && new_y > 0 and new_y <= @board.range
  end
end