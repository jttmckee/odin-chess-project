require 'Piece.rb'
class King < Piece

  def legal_move?(new_x,new_y)
    diff_x = (Board.sym_to_i(new_x) - Board.sym_to_i(@x)).abs
    diff_y = (new_y - @y).abs
    legal = (diff_x + diff_y == 1 ) && super(new_x,new_y)
  end


end
