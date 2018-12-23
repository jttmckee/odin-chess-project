require 'Piece.rb'
class King < Piece

  def legal_move?(new_x,new_y)
    diff_x, diff_y = diff(new_x,new_y)
    legal = [0,1].include?(diff_x) && [0,1].include?(diff_y) && super(new_x,new_y)
    check = @board.pieces do |piece|
      piece != self && piece.legal_move?(new_x,new_y)
    end.size > 0
    legal and not check
  end


end
