require 'piece.rb'

class Knight < Piece
  def legal_move?(new_x,new_y)
    diff_x, diff_y =  Board.diff(@x,new_x,@y,new_y)
    legal = (diff_x == 1 && diff_y == 3) ||  (diff_x == 3 && diff_y == 1)
    return legal && super(new_x,new_y)
  end

end
