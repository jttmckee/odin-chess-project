require './lib/board.rb'
require './lib/king.rb'
require './lib/knight.rb'
require './lib/queen.rb'
require './lib/bishop.rb'
require './lib/rook.rb'
require './lib/pawn.rb'

class Game
  INPUT_REGEX =
    /
    \A                #start of string
    (?<piece>[A-Z])?  #optional piece letter.  Pawn if not
    (?<from_x>[a-h])? #from col, only needed if more than one piece
    (?<from_y>[1-8])? #from row - ditto not needed
    x?                #x is sometimes used to denote capture - not used
    (?<to_x>[a-h])    #to col - needed
    (?<to_y>[1-8])    #from col - needed
    =?                #optionally used in promotion not needed
    (?<promote>[A-Z]?) #denotes piece to promote to
    \z                #end of string
    /x
  ERROR_NOT_LEGAL = "Error: Not a legal move.  For Help type 'help'"
  ERROR_ONE_PIECE =
    <<~MESSAGE
    Error: More than one piece possible.
    Please specify using algebraic notation.
    For Help type 'help'
    MESSAGE
  ERROR_CANT_PROMOTE = "Error: Cannot promote until you reach the end"
  ERROR_MUST_PROMOTE = "Error: You must indicate how you want to promote"
  ERROR_PROMOTE_PIECE = "Error: Please specify the correct piece to promote"
  attr_reader :board, :turn
  def initialize
    @board = Board.new
    @turn = :white
    set_up_side(:white,1)
    set_up_side(:black,8)
  end

  def interpret_move(move_string)
    move = INPUT_REGEX.match(move_string)
    if move == nil
      puts ERROR_NOT_LEGAL
      return false
    end
    unless move[:piece]
      type_piece = Pawn
    else
      type_piece = determine_piece_from move[:piece]

    end
    if type_piece == nil
      puts ERROR_NOT_LEGAL
      return false
    end
    x = move[:to_x].to_sym
    y = move[:to_y].to_i
    pieces = @board.pieces do |p|
      p.class == type_piece && p.colour == @turn && p.legal_move?(x,y) &&
      [nil,"",p.x.to_s].include?(move[:from_x]) &&
      [nil,"",p.y.to_s].include?(move[:from_y])

    end
    if pieces.size == 0
      puts ERROR_NOT_LEGAL
      return false
    end
    if pieces.size >= 2
      puts ERROR_ONE_PIECE
      return false
    end
    if move[:promote] != "" && type_piece == Pawn
      if %w{R N B Q}.include?(move[:promote]) && [1,8].include?(y)
        new_type = determine_piece_from move[:promote]
        new_piece = new_type.new(x,y,@turn,@board)
        @board.delete_piece pieces[0]
      elsif [1,8].include?(y)
        puts ERROR_PROMOTE_PIECE
        return false
      else
        puts ERROR_CANT_PROMOTE
        return false
      end
    elsif type_piece == Pawn && [1,8].include?(y)
      puts ERROR_MUST_PROMOTE
      return false
    else
      board.move(pieces[0],x,y)
    end
    if checkmate? then puts 'CHECKMATE' end
    @turn = @turn == :white ? :black : :white
  end
  private
  def set_up_side(colour,home)
    row2 = home == 1 ? 2 : 7
    #set up pawns
    8.times {|i| Pawn.new(Board.i_to_sym(i+1),row2,colour,@board)}
    #King and #Queen
    if (home == 1 && colour == :white) || (home == 8 && colour == :black)
      disp = 1
    else
      disp = 0
    end
    King.new(Board.i_to_sym(4+disp),home,colour,@board)
    Queen.new(Board.i_to_sym(5-disp),home,colour,@board)
    Rook.new(:a,home,colour,@board)
    Rook.new(:h,home,colour,@board)
    Knight.new(:b,home,colour,@board)
    Knight.new(:g,home,colour,@board)
    Bishop.new(:c,home,colour,@board)
    Bishop.new(:f,home,colour,@board)
  end

  def determine_piece_from (letter)
    case letter
    when 'P' then Pawn
    when 'R' then Rook
    when 'N' then Knight
    when 'B' then Bishop
    when 'Q' then Queen
    when 'K' then King
    else nil
    end
  end

  def checkmate?
    colour = @turn == :white ? :black : :white
    kings = @board.pieces {|p| p.class == King && p.colour == colour}
    return false unless kings.size == 1
    king = kings[0]
    return false unless in_check? king
    checkmate = false
    pieces = @board.pieces {|p| p&.colour == colour}
    pieces.each do |piece|
      moves = piece.legal_moves
      moves.each do |move|
        x, y = move[0], move[1]
        moved, old_x, old_y = piece.moved, piece.x, piece.y
        old_piece = @board[x,y]
        @board.force_move(piece,x,y)
        checked = @board.pieces do |p|
          p != nil &&
          p != king &&
          p.colour != colour && piece.legal_move?(king.x,king.y)
        end.size > 0
        @board.force_move(piece,old_x,old_y)
        @moved = moved
        @board.new_piece  old_piece if old_piece
        checkmate = checkmate || checked
      end
    end
  end

  def in_check? (king)
    @board.pieces do |piece|
      piece != nil &&
      piece != king &&
      piece.colour != king.colour &&
      piece.legal_move?(king.x,king.y)
    end.size > 0
  end
end
