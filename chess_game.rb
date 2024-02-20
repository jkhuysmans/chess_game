require './chess_board.rb'
require './chess_pieces.rb'

class ChessGame

    def initialize
        @board = ChessBoard.new
        @current_turn = 'white'
        @moves_number = 0
    end

    def display
        puts "#{@board.display}", " "
    end

    def raw_board
        p @board.raw_board
    end

    def round
        display
        select_piece
    end

    def select_piece
        puts "Enter the piece you want to select:"
        piece = nil
        
        loop do
            selected_piece = gets.chomp
            valid, piece, position = selection_valid?(selected_piece)
            if valid
                if piece.nil?
                    puts "There is no piece at this emplacement. Please try again:"
                else
                    p piece
                    move_piece(piece)
                    break
                end
            end
        end
        
    end

    def move_piece(piece)
        puts "Where do you want to put the piece?"

            loop do
                emplacement = gets.chomp
                valid, _, target_position = selection_valid?(emplacement)
                if valid_move?(piece, target_position)
                    piece_class = piece.class
                    p "PIECE CLASS: #{piece_class}"
                    p "TARGET POSITION: #{target_position}"
                    old_position = piece.position
                    p "OLD PIECE POSITION: #{old_position}"
                    @board.board[old_position[0]][old_position[1]] = nil
                    @board.board[target_position[0]][target_position[1]] = piece 
                    piece.position = target_position
                    puts "Move valid. Piece moved."
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

game = ChessGame.new
game.round