require './chess_pieces.rb'


class ChessBoard
    attr_accessor :board

    def initialize
        @board = Array.new(8) { Array.new(8) }
        setup_pieces
    end

    def display
        @board.push([1, 2, 3, 4, 5, 6, 7, 8])

        letters = ["h", "g", "f", "e", "d", "c", "b", "a", " "]

        @board.map.with_index do |row, index|
            row.unshift(letters[index])
        end

        @board.map.with_index do |row|
            row.map do |column|
                if column.is_a?(String) || column.is_a?(Numeric)
                    column.to_s
                else
                    column.nil? ? "." : column.name
                end
            end.join(" ")
          end.join("\n")
    end

    def setup_pieces
        8.times do |i|
          @board[1][i] = Pawn.new([1, i], 'black')
          @board[6][i] = Pawn.new([6, i], 'white')
        end
       
        @board[0][0] = Rook.new([0, 0], 'white')
        @board[0][7] = Rook.new([0, 7], 'white')
        @board[7][0] = Rook.new([7, 0], 'black')
        @board[7][7] = Rook.new([7, 7], 'black')
    
        @board[0][1] = Knight.new([0, 1], 'white')
        @board[0][6] = Knight.new([0, 6], 'white')
        @board[7][1] = Knight.new([7, 1], 'black')
        @board[7][6] = Knight.new([7, 6], 'black')
    
        @board[0][2] = Bishop.new([0, 2], 'white')
        @board[0][5] = Bishop.new([0, 5], 'white')
        @board[7][2] = Bishop.new([7, 2], 'black')
        @board[7][5] = Bishop.new([7, 5], 'black')
    
        @board[0][3] = King.new([0, 3], 'white')
        @board[7][3] = King.new([7, 3], 'black')
    
        @board[0][4] = Queen.new([0, 4], 'white')
        @board[7][4] = Queen.new([7, 4], 'black')    
      end

      def raw_board
        @board
      end
end

