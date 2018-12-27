require './lib/board.rb'


class Piece
  attr_reader :board, :colour
  attr_accessor :x, :y
  def initialize(x,y,colour,board)
    unless board[x,y] == nil
       raise "Error - there is already a piece at location #{x},#{y}"
    end
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
    #diagonal moves - check the path is clear
    start_x = Board.sym_to_i(@x)
    diff_x,diff_y = diff(new_x,new_y)
    if diff_x == diff_y && diff_y >= 2
      in_path = (@x...new_x).to_a.any? do |temp_x|
        ctr = (Board.sym_to_i(temp_x) - Board.sym_to_i(@x)).abs
        temp_y = (@y...new_y).to_a[ctr]
        temp_x != @x && @board[temp_x,temp_y] != nil
      end
    else
      in_path = false
    end
    #end diagonal moves
    @board.in_range?(new_x,new_y) &&
    (@board[new_x,new_y]&.colour != self.colour) &&
    (! in_path)

  end

  def home
    @board.home(self)
  end

protected
  def diff(new_x,new_y)
    diff_x = (Board.sym_to_i(new_x) - Board.sym_to_i(@x)).abs
    diff_y = (new_y - @y).abs
    return diff_x, diff_y
  end

end
