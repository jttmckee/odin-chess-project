require './lib/game.rb'

game = Game.new

while true do
  game.board.display
  puts "It's #{game.turn.to_s}'s turn."
  puts "For help type \"help\""
  input = gets.chomp
  if  input.downcase =~ /save/
    game.save
    puts "Game saved!"
  elsif input.downcase =~ /help/
    game.help
  elsif input.downcase =~ /quit/
    break
  elsif input.downcase =~ /open/
    files = Dir["./save/*"].sort_by { |file_name| File.stat(file_name).mtime }
    ctr = 0
    files.each do |filename|
      puts "#{ctr.to_s}:  #{filename.to_s}"
      ctr += 1
    end
    while true
      puts "Type number of filename you want to use"
      filenumber = gets.chomp
      unless filenumber =~ /\A\d+\z/
        puts "Please type a number and only a number"
        next
      end
      filenum = filenumber.to_i
      unless filenum.between?(0,files.size-1)
        puts "Please type a number between zero and #{files.size-1}"
        next
      end
      filename = files[filenum]
      game.open filename
      break
    end

  else
    game.interpret_move(input)
    if game.checkmate
      game.board.display
      puts 'CHECKMATE'
      puts 'Press any key to finish'
      empty = gets
      break
    end
  end

end
