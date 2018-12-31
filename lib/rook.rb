require 'piece.rb'
class Rook < Piece

  def legal_move?(new_x,new_y)
    ((@x == new_x) ^ (@y == new_y)) && super
  end

end
