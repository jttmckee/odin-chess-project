class Board
  attr_reader :range
  def initialize(range)
    @range = range
  end
  def new_piece=(piece)
    unless piece.x > 0 and piece.y > 0 and piece.x <= @range and piece.y <= @range
      return false
    else
      @grid[piece.x,piece.y] = piece
      return true
    end
  end
  def [](x,y)
    unless x > 0 and y > 0 and x <= @range and y <= @range
      return nil
    else
      return @grid[x,y]
    end
  end

end
