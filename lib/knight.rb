require 'piece.rb'

class Knight < Piece
  def legal_move?(new_x,new_y)
    diff_x = (Board.sym_to_i(new_x) - Board.sym_to_i(@x)).abs
    diff_y = (new_y - @y).abs
    legal = (diff_x == 1 && diff_y == 3) ||  (diff_x == 3 && diff_y == 1)
    return legal && super(new_x,new_y)
  end

end
