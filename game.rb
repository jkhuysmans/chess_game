require './chess_game.rb'

def intro
    puts "Welcome to chess. Chess is a strategic board game played between two opponents on a checkered gameboard with 64 squares arranged in an 8×8 grid. Each player commands an army of 16 pieces, with the ultimate goal of checkmating the opponent's king."
    puts "Would you like to start a new game ('new'), load a savestate ('load'), or exit the game? ('exit')"

    loop do
        input = gets.chomp.to_s.downcase

        if input == "new"
            game = ChessGame.new
            puts "If possible, a draw can be made typing 'draw'. At any start of a round, a player can type 'save' to save and 'exit' to end the game."
            sleep(1)
            game.start
        elsif input == "load"
            load_game
        elsif input == "exit"
            return 
        else
            puts "Invalid input. Please enter 'new' to start a new game, 'load' to load a savestate of 'exit' to leave."
        end
    end
end

def load_game
    puts "Here is a list of all the available saves:"
    available_saves = []
    Dir.glob('saves/*').each do |file_name|
        available_saves << File.basename(file_name, File.extname(file_name))
    end

    if available_saves.empty?
        puts "No available save."
        sleep(1)
        intro
    else
        available_saves.each_with_index do |save, i|
            puts "#{i + 1}) #{save}"
        end

        loop do

        save_input = gets.chomp.to_i
        selected_save = available_saves[save_input - 1]

        if selected_save
            file_path = "saves/#{selected_save}.yaml"
            if File.exist?(file_path)
                yaml_content = File.read(file_path, encoding: 'utf-8')
                game_state = YAML.load(yaml_content, permitted_classes: [ChessGame, ChessBoard, ChessBoardDebug, ChessPieces, Pawn, Bishop, King, Knight, Queen, Rook], aliases: true)
                puts "Game loaded successfully!"
                game_state.start

                break
            else
                puts "Failed to load the selected save."
            end
        else
            puts "Invalid selection."
        end
        end
    end
end

intro