require './chess_board.rb'
require './chess_board_debug.rb'
require './chess_pieces.rb'

class ChessGame

    def initialize
        #Debug for testing pieces' properties
        @board = ChessBoardDebug.new
        @white = 0
        @black = 0
        @round = 0
        @current_round = 0
    end

    def display
        puts "#{@board.display}", " "
    end

    def raw_board
        p @board.raw_board
    end

    def round
        puts "White's points: #{@white}"
        puts "Black's points: #{@black}"
        reset_en_passant_flags

        display
        @round += 1

        if @round.even?
            current_player_color = "white"
        elsif @round.odd?
            current_player_color = "black"
        end

        select_piece(current_player_color)
    end

    def reset_en_passant_flags
        @board.board.each do |row|
          row.each do |piece|
            if piece.is_a?(Pawn) && (@current_round + 3) == @round
              piece.en_passant = false
            end
          end
        end
      end      

    def select_piece(current_player_color)
        puts "Enter the piece you want to select:"
        piece = nil
        
        loop do
            selected_piece = gets.chomp
            valid, piece, position = selection_valid?(selected_piece)
            if valid
                if piece.nil?
                    puts "There is no piece at this emplacement. Please try again:"
                elsif piece.color != current_player_color
                    puts "You cannot pick one of the pieces of the other player."
                else
                    move_piece(piece, current_player_color)
                    break
                end
            end
        end
        
    end

    def move_piece(piece, current_player_color)
        puts "Where do you want to put the piece?"
            possible_moves = piece.moves

            loop do
                emplacement = gets.chomp
                valid, _, target_position = selection_valid?(emplacement)
                old_position = piece.position

                check_en_passant(piece, old_position, target_position) if piece.name == "P"
                
                if valid_move?(piece, target_position)
                    @board.board[old_position[0]][old_position[1]] = nil
                    target = @board.board[target_position[0]][target_position[1]]
                    capture_piece(piece, target, current_player_color) unless target == nil
                        
                    @board.board[target_position[0]][target_position[1]] = piece 
                    piece.position = target_position

                    puts "Move valid. Piece moved."
                    piece.moves_number if piece.name == "P"
                    sleep(1)
                    round
                    break
                else
                    puts "Invalid move. Please try again."
                end
            end
    end

    def check_en_passant(piece, old_position, target_position)
        if piece.is_a?(Pawn) && (old_position[0] - target_position[0]).abs == 2
            @current_round = @round
            piece.en_passant = true
        end
    end

    def valid_move?(piece, target_position)

        position = piece.position
        possible_moves = piece.moves

        return true if possible_moves.include?(target_position)
        return false if piece.color == @board.board[target_position[0]][target_position[1]].color
    end

    def capture_piece(piece, target, current_player_color)
        puts "Piece captured!"
        if current_player_color == "white"
            @white += target.point_value
        else
            @black += target.point_value
        end

        end_game(piece) if target.name == "K"
    end

    def selection_valid?(selected_piece)

        if selected_piece.nil? || selected_piece.length != 2
            puts "Invalid input. Please enter a valid position (e.g., 'e2')."
            return [false, nil, nil]
        end
        
        column = selected_piece[0].downcase.ord - 'a'.ord
        row = selected_piece[1].to_i - 1

        if (0..7).include?(row) && (0..7).include?(column)
            piece = @board.board[row][column]

            return true, piece, [row, column]
        else
            puts "Wrong input"
        end 

    end

    def end_game(piece)
        p piece.color

    end

end
