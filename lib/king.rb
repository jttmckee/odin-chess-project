require 'piece.rb'
require 'rook.rb'
class King < Piece

  def legal_move?(new_x,new_y)
    diff_x, diff_y = diff(new_x,new_y)
    if (diff_x == 2) && diff_y == 0 && moved == false then
      #castling moves
      rook_x = new_x < @x ? :a : @board.range_x
      rook = @board[rook_x,y]
      unless rook.class == Rook && rook.colour == self.colour && rook.moved == false
        return false
      else
        min = @x < new_x ? @x : new_x; max = @x > new_x ? @x : new_x
        check = (min..max).to_a.any? {|x_| checked?(x_,@y) }
        min = @x < rook_x ? @x : rook_x; max = @x > rook_x ? @x : rook_x
        min = (min.to_s.ord + 1).chr.to_sym
        in_path = (min...max).to_a.any? {|x_| @board[x_,@y] != nil}
        return !(check) && !(in_path) && super
      end

    else
      #standard moves
      legal = [0,1].include?(diff_x) && [0,1].include?(diff_y) && super
        return legal && !(checked?(new_x,new_y))
    end

  end
protected
  def base_display
    "\u2654"
  end

private
  def checked? (x,y)
    @board.pieces do |piece|
      piece != self && piece.colour != self.colour && piece.legal_move?(x,y)
    end.size > 0
  end

end
