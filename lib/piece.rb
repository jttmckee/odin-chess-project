require './lib/board.rb'


class Piece
  attr_reader :board, :colour
  attr_accessor :x, :y
  attr_accessor :moved
  def initialize(x,y,colour,board)
    unless board[x,y] == nil
       raise "Error - there is already a piece at location #{x},#{y}"
    end
    @x=x;@y=y
    @board=board
    self.colour = colour
    @board.new_piece  self
    @moved = false
  end

  def colour=(colour)
    if [:white,:black].include? colour
      @colour = colour
    else
      raise ("Colour can only be set to white or black")
    end
  end

  def legal_move?(new_x,new_y)
    diff_x,diff_y = diff(new_x,new_y)
    start_x = Board.sym_to_i(@x)
    #diagonal moves - check the path is clear
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
    #linear moves - check the path is clear
    if diff_x == 0 && diff_y != 0 then in_linear_path = (linear_path?(new_y))
    elsif diff_y == 0 && diff_x != 0 then in_linear_path = (linear_path?(new_x))
    else in_linear_path = false
    end
    #end linear moves
    in_path = in_path || in_linear_path
    @board.in_range?(new_x,new_y) &&
    (diff_y != 0 || diff_x != 0) &&
    (@board[new_x,new_y]&.colour != self.colour) &&
    (! in_path)

  end

  def legal_moves
    moves = []
    (:a..@board.range_x).each do |x|
      (1..@board.range).each do |y|
        moves << [x,y] if legal_move?(x,y)
      end
    end
    moves
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

private
  def linear_path?(new_pos)
    if new_pos.class == Symbol
      return (@x...new_pos).to_a.any? do |temp_x|
         temp_x != @x && @board[temp_x, @y] != nil
      end
    elsif new_pos.class == Integer
      return (@y...new_pos).to_a.any? do |temp_y|
         temp_y != @y && @board[@x,temp_y] != nil
      end
    else
      raise "Error linear_path? Expecting Integer or Symbol"
    end

  end

end
