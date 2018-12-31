class Queen < Piece

  def legal_move?(new_x, new_y)
    diff_x,diff_y = diff(new_x,new_y)
    ((diff_x == diff_y) ^
    ((@x == new_x) ^ (@y == new_y))) &&
     super
  end

end
