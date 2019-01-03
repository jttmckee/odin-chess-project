require './lib/piece.rb'

class Knight < Piece
  def legal_move?(new_x,new_y)
    diff_x, diff_y = diff(new_x,new_y)
    legal = (diff_x == 1 && diff_y == 2) ||  (diff_x == 2 && diff_y == 1)
    return legal && super(new_x,new_y)
  end
  protected
    def base_display
      "\u2658"
    end
end
