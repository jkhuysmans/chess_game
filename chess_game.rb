require './chess_board.rb'
require './chess_pieces.rb'

class ChessGame

    def initialize
        @board = ChessBoard.new
        @current_turn = 'white'
    end

    def display
        puts "#{@board.display}", " "
    end

    def raw_board
        p @board.raw_board
    end

    def select_piece
        display
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
                    puts "Piece's position: #{piece.position}"
                    puts "User's selection: #{position}"

                    move_piece(piece)
                end
            end
        end
        
    end

    def move_piece(piece)
        puts "Where do you want to put the piece?"

            loop do
                emplacement = gets.chomp
                valid, _, target_position = selection_valid?(emplacement)
                puts "Piece: #{piece}"
                puts "Target position: #{target_position}"
                if valid_move?(piece, target_position)
                    @board.board[target_position[0] + 1][target_position[1]] = piece 
                    puts "Move valid. Piece moved."
                    display
                    break
                else
                    puts "Invalid move. Please try again."
                end
            end
    end

    def valid_move?(piece, target_position)
        position = piece.position
        possible_moves = piece.moves
  
        possible_moves.include?(target_position)
    end

    def selection_valid?(selected_piece)
        
        row = selected_piece[0].downcase.ord - 'a'.ord 
        column = selected_piece[1].to_i - 1

        if (0..8).include?(row) && (0..8).include?(column)
            piece = @board.board[row][column]

            return true, piece, [row, column]
        else
            puts "wrong input"
        end 

    end

end

game = ChessGame.new
game.select_piece