require './lib/game.rb'

RSpec.describe Game do
  describe "#new" do
    it "correctly sets up a game board" do
      game = Game.new
      expect {game.board.display}.to output(<<-BOARD).to_stdout
    a   b   c   d   e   f   g   h
  ┏━━━┳━━━┳━━━┳━━━┳━━━┳━━━┳━━━┳━━━┓
 8┃ ♜ ┃▌♞▐┃ ♝ ┃▌♛▐┃ ♚ ┃▌♝▐┃ ♞ ┃▌♜▐┃8
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 7┃▌♟▐┃ ♟ ┃▌♟▐┃ ♟ ┃▌♟▐┃ ♟ ┃▌♟▐┃ ♟ ┃7
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 6┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃6
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 5┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃5
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 4┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃4
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 3┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃▌ ▐┃   ┃3
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 2┃ ♙ ┃▌♙▐┃ ♙ ┃▌♙▐┃ ♙ ┃▌♙▐┃ ♙ ┃▌♙▐┃2
  ┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
 1┃▌♖▐┃ ♘ ┃▌♗▐┃ ♕ ┃▌♔▐┃ ♗ ┃▌♘▐┃ ♖ ┃1
  ┗━━━┻━━━┻━━━┻━━━┻━━━┻━━━┻━━━┻━━━┛
    a   b   c   d   e   f   g   h
        BOARD
    end
  end

  describe "#interpret_move" do
    subject(:game) {Game.new}
    let(:game2) do
      game2 = Game.new
      (:a..:h).to_a.each do |x|
        game2.board.delete_piece game2.board[x,2]
        game2.board.delete_piece game2.board[x,7]
      end
      game2
    end
    it "correctly moves a pawn using algebraic notation" do
        pawn = game.board[:h,2]
        game.interpret_move('h3')
        expect(game.board[:h,3]).to eq(pawn)
    end
    it "changes the turn after playing" do
        game.interpret_move('h3')
        expect(game.turn).to eq(:black)
    end
    it "correctly rejects unclear move(no pawn available)" do
        expect{game.interpret_move('h6')}.to output(
          "Error: Not a legal move.  For Help type 'help'\n").to_stdout
        expect(game.board[:h,6]).to eq(nil)
    end
    it "correctly rejects unclear move(two pieces)" do
        pawn = game.board[:h,2]
        game.interpret_move('h4')
        game.interpret_move('g5')
        game.interpret_move('f4')
        game.interpret_move('e5')
        expect{game.interpret_move('g5')}.to output(
          <<~MESSAGE
          Error: More than one piece possible.
          Please specify using algebraic notation.
          For Help type 'help'
          MESSAGE
        ).to_stdout
    end

    it "correctly rejects false promotion" do
        expect{game.interpret_move('g3Q')}.to output(
          "Error: Cannot promote until you reach the end\n"
        ).to_stdout
    end
    it "correctly accepts a genuine promotion" do
        game2.interpret_move('Nh3')
        pawn = Pawn.new(:g,2,:black,game2.board)
        game2.interpret_move('g1Q')
        expect(game2.board[:g,1].class).to eq(Queen)
    end
    it "insists on promotion" do
        game2.interpret_move('Nh3')
        pawn = Pawn.new(:g,2,:black,game2.board)
        expect{game2.interpret_move('g1')}.to output(
        "Error: You must indicate how you want to promote\n").to_stdout

    end
    it "correctly inteprets clear move(two pieces)" do
        pawn = game.board[:h,2]
        pawn2 = game.board[:f,2]
        game.interpret_move('h4')
        game.interpret_move('g5')
        game.interpret_move('f4')
        game.interpret_move('e5')

        game.interpret_move('fg5')
        expect(game.board[:g,5]).to eq(pawn2)
    end
    it "correctly inteprets a knight move" do
        knight = game.board[:g,1]
        game.interpret_move('Nh3')
        expect(game.board[:h,3]).to eq(knight)
    end
    it "correctly inteprets a black king move" do
        king = game2.board[:e,8]
        game2.interpret_move('Ra4')
        game2.interpret_move('Kf7')
        expect(game2.board[:f,7]).to eq(king)
    end
    it "correctly inteprets a Queen move" do
        queen = game2.board[:d,1]
        game2.interpret_move('Qf3')
        expect(game2.board[:f,3]).to eq(queen)
    end
    it "correctly inteprets a Bishop move" do
        bishop = game2.board[:c,1]
        game2.interpret_move('Bf4')
        expect(game2.board[:f,4]).to eq(bishop)
    end
    it "rejects nonsense moves" do
      expect{game2.interpret_move('Kd2')}.to output(
        "Error: Not a legal move.  For Help type 'help'\n"
      ).to_stdout
    end

    it "insists on coming out of check" do
      game2.interpret_move('Qe2')
      expect{game2.interpret_move('Nh6')}.to output(
        "Error: Not a legal move.  For Help type 'help'\n"
      ).to_stdout
    end
    it "allows move out of check" do
      game2.interpret_move('Qe2')
      game2.interpret_move('Qe7')
      expect(game2.board[:e,7].class).to eq(Queen)
    end
    it "doesn't let a King move into check" do
      expect{game2.interpret_move('Kd2')}.to output(
        "Error: Not a legal move.  For Help type 'help'\n"
      ).to_stdout

    end
    it "recognizes checkmate" do
      game.interpret_move('g4')
      game.interpret_move('e6')
      game.interpret_move('f3')
      #game.interpret_move('h4')
      expect{game.interpret_move('Qh4')}.to output(
        "CHECKMATE\n"
      ).to_stdout
      expect(game.checkmate).to be true

    end
    it "doesn't falsely claim checkmate" do
      game.interpret_move('g4')
      game.interpret_move('e6')
      game.interpret_move('f3')
      game.interpret_move('a6')
      game.interpret_move('e3')
      game.interpret_move('Qh4')
      expect(game.checkmate).to be false
    end
    it "doesn't falsely claim checkmate(2)" do
      game.interpret_move('e3')
      game.interpret_move('f6')
      game.interpret_move('Qh5')
      expect(game.checkmate).to be false
    end
  end
  describe "#help" do
    it "outputs the contents of the help file" do
      test_help_file =  open './help/help.txt'
      help_contents = test_help_file.read
      test_help_file.close
      expect{subject.help}.to output(
        help_contents
      ).to_stdout
    end
  end
  describe "#save" do
    it "saves an additional file" do
      number = Dir.entries("./save/").size
      subject.save
      expect(Dir.entries("./save/").size - number).to eq(1)
    end
  end
  describe "#open" do
    let(:game2) do
      game2 = Game.new
      (:a..:h).to_a.each do |x|
        game2.board.delete_piece game2.board[x,2]
        game2.board.delete_piece game2.board[x,7]
      end
      game2
    end
    it "opens a saved file returning game to this state" do
      game2.interpret_move('Rh4')
      game2.save
      game2.interpret_move('Rh5')
      most_recent =
        Dir["./save/*"].sort_by { |file_name| File.stat(file_name).mtime }[-1]
      saved_game = Game.new
      saved_game.open most_recent
      expect(saved_game.board[:h,1]).to eq nil
      expect(saved_game.board[:h,2]).to eq nil
      expect(saved_game.board[:h,4].class).to eq Rook
      expect(saved_game.board[:h,5]).to eq nil
      expect(saved_game.turn).to eq :black
    end
  end

end
