require 'set.rb'
require './lib/piece.rb'

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

  def delete_piece (piece)
    @grid[[piece.x,piece.y]] = nil
    piece = nil
  end

  def in_range? (x,y)
    x.class == Symbol && (:a..:h).to_a.include?(x) &&
    y.class == Integer && (1..8).to_a.include?(y)
  end

  def move(piece,new_x,new_y)
    unless piece.legal_move? new_x, new_y
      raise "Illegal move"
    end
    diff_x, diff_y = piece.diff(new_x,new_y)
    if piece.class == King && diff_x == 2 then
      rook_x = new_x < piece.x ? :a : range_x
      rook_diff = new_x < piece.x ? +1 : -1
      rook_new_x = (new_x.to_s.ord + rook_diff).chr.to_sym
      rook = @grid[[rook_x,piece.y]]
      @grid.delete([rook.x,rook.y])
      @grid[[rook_new_x,rook.y]] = rook
      rook.x = rook_new_x
      rook.moved = true
    end
      @taken.add(@grid[[new_x,new_y]]) if @grid[[new_x,new_y]] != nil
      @grid.delete([piece.x,piece.y])
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

  def display
     puts "    a   b   c   d   e   f   g   h"
     print"  ┏"; (@range-1).times {print "━━━┳"};print "━━━┓\n";
     @range.times do |row|
       y = @range - row
       print " #{y}┃"
       (@range).times do |col|
         x = Board.i_to_sym(col+1)
         pe = @grid[[x,y]] ? @grid[[x,y]].display : " "
         print ((row + col).even? ? " #{pe} " : "▌#{pe}▐") + "┃"
       end
       print "#{y}\n"
       if row != @range-1 then
         print"  ┣"; (@range-1).times {print "━━━╋"};print "━━━┫\n";
       else
         print"  ┗"; (@range-1).times {print "━━━┻"};print "━━━┛\n";
       end
     end
     puts "    a   b   c   d   e   f   g   h"
  end

#Class helpers
  def self.sym_to_i(x)
    x.to_s.ord - 96
  end
  def self.i_to_sym(x)
    (x+96).chr(Encoding::UTF_8).to_sym
  end
end
