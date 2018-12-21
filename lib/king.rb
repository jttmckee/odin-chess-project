require 'Piece.rb'
class King < Piece

  def legal_move?(new_x,new_y)
    diff_x, diff_y = diff(new_x,new_y)
    legal = (diff_x + diff_y == 1 ) && super(new_x,new_y)
  end


end
