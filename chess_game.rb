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
        display
        @round += 1

        if @round.even?
            current_player_color = "white"
        elsif @round.odd?
            current_player_color = "black"
        end

        select_piece(current_player_color)
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
                
                if valid_move?(piece, target_position)
                    old_position = piece.position
                    @board.board[old_position[0]][old_position[1]] = nil
                    target = @board.board[target_position[0]][target_position[1]]

                    unless target == nil
                        capture_piece(piece, target, current_player_color)
                        target = piece 
                    else
                        target = piece 
                    end

                    piece.position = target_position
                    puts "Move valid. Piece moved."
                    sleep(1)
                    round
                    break
                else
                    puts "Invalid move. Please try again."
                end
            end
    end

    def valid_move?(piece, target_position)

        position = piece.position
        possible_moves = piece.moves
  
        return true if possible_moves.include?(target_position)
    end

    def capture_piece(piece, target, current_player_color)
        puts "Piece captured!"
        if current_player_color == "white"
            @white += target.point_value
        else
            @black += target.point_value
        end
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

end
