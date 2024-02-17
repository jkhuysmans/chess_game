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
        puts "Enter the piece you want to select:"
        piece = nil
        
        loop do
            selected_piece = gets.chomp
        
            row = selected_piece[0].downcase.ord - 'a'.ord 
            column = selected_piece[1].to_i - 1

            if (0..7).include?(row) && (0..7).include?(column)
                puts "Row: #{row}, Column: #{column}"
                piece = @board.board[row][column]

                if piece.nil?
                    puts "There is no piece at this emplacement. Please try again:"
                else
                    break
                end
            else
                puts "wrong input"
            end 
        end
        p piece
    end

end

game = ChessGame.new
game.display
game.select_piece