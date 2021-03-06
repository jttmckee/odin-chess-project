require './lib/piece.rb'

class Bishop < Piece

  def legal_move?(new_x, new_y)
    diff_x,diff_y = diff(new_x,new_y)
    super && diff_x == diff_y
  end
protected
  def base_display
    "\u2657"
  end
end
