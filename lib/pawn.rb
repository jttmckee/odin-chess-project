require './lib/piece.rb'

class Pawn < Piece

  def legal_move?(new_x,new_y)
    diff_x,diff_y = diff(new_x,new_y)
    direction = (2-home)/((home-2).abs)
    diff_y = (new_y - @y) * direction
    #can move two at start
    allowed_y = (@y - home).abs == 1 ? [1,2] : [1]
    #Move sideways to take otherwise move forwards
    allowed_x = [@colour,nil].include?(@board[new_x,new_y]&.colour) ? 0 : 1
    super(new_x,new_y) && allowed_y.include?(diff_y) && diff_x == allowed_x

  end

  protected
    def base_display
      "\u2659"
    end

end
