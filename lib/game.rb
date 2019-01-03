require './lib/board.rb'
require './lib/king.rb'
require './lib/knight.rb'
require './lib/queen.rb'
require './lib/bishop.rb'
require './lib/rook.rb'
require './lib/pawn.rb'

class Game
  attr_reader :board
  def initialize
    @board = Board.new
    set_up_side(:white,1)
    set_up_side(:black,8)
  end

  private
  def set_up_side(colour,home)
    row2 = home == 1 ? 2 : 7
    #set up pawns
    8.times {|i| Pawn.new(Board.i_to_sym(i+1),row2,colour,@board)}
    #King and #Queen
    if (home == 1 && colour == :white) || (home == 8 && colour == :black)
      disp = 1
    else
      disp = 0
    end
    King.new(Board.i_to_sym(4+disp),home,colour,@board)
    Queen.new(Board.i_to_sym(5-disp),home,colour,@board)
    Rook.new(:a,home,colour,@board)
    Rook.new(:h,home,colour,@board)
    Knight.new(:b,home,colour,@board)
    Knight.new(:g,home,colour,@board)
    Bishop.new(:c,home,colour,@board)
    Bishop.new(:f,home,colour,@board)
  end
end
