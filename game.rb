require './chess_game.rb'

def intro
    puts "Welcome to chess."
    puts "Would you like to start a new game ('new'), or load a savestate? ('load')"

    loop do
        input = gets.chomp.to_s.downcase

        if input == "new"
            game = ChessGame.new
            puts "If possible, a draw can be made typing 'draw'. At any start of a round, a player can type 'save' to save and 'exit' to end the game."
            sleep(1)
            game.start
        elsif input == "load"

        end
    end
end

intro