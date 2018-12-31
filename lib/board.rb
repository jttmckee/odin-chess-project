require 'set.rb'

class Board
  attr_reader :range, :taken
  def initialize(range=8)
    @range = range
    @grid = Hash.new
    @taken = Set.new
    @home = {white: 1,black: 8}
  end

  def new_piece(piece)
    unless in_range?(piece.x,piece.y) &&
      (self[piece.x,piece.y] == nil)
      return false
    else
      @grid[[piece.x,piece.y]] = piece
      return true
    end
  end

  def [](x,y)
    unless in_range?(x,y)
      return nil
    else
      return @grid[[x,y]]
    end
  end

  def in_range? (x,y)
    x.class == Symbol && (:a..:h).to_a.include?(x) &&
    y.class == Integer && (1..8).to_a.include?(y)
  end

  def move(piece,new_x,new_y)
    unless piece.legal_move? new_x, new_y
      raise "Illegal move"
    end
    @taken.add(@grid[[new_x,new_y]]) if @grid[[new_x,new_y]] != nil
    @grid[[new_x,new_y]] = piece
    piece.x = new_x;piece.y = new_y
    piece.moved = true
  end

  def range_x
    return (96+@range).chr.to_sym
  end
  def range_y
    return @range
  end

  def home(piece)
    @home[piece.colour]
  end

  def set_home(piece,row)
    @home[piece.colour] = row
    @home[piece.colour == :white ? :black : :white] = @range + 1 - row
  end

  def pieces
    unless block_given?
      @grid.values
    else
      @grid.values.select {|piece| yield(piece) }
    end
  end

#Class helpers
  def self.sym_to_i(x)
    x.to_s.ord - 96
  end

end
