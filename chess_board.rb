require './chess_pieces.rb'

Dir.glob(File.join(__dir__, 'pieces', '*.rb')).each do |file|
    require_relative file
  end


class ChessBoard
    attr_accessor :board

    def initialize
        @board = Array.new(8) { Array.new(8) }
        setup_pieces
    end

    def display
        display_board = Marshal.load(Marshal.dump(@board))
        display_board.push(["a", "b", "c", "d", "e", "f", "g", "h"])

        numbers = [1, 2, 3, 4, 5, 6, 7, 8, " "]
        letters = ["a", "b", "c", "d", "e", "f", "g", "h", " "]

        display_board.map.with_index do |row, index|
            row.unshift(numbers[index])
        end

        display_board.map.with_index do |row|
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
          @board[6][i] = Pawn.new([6, i], 'white')
          @board[1][i] = Pawn.new([1, i], 'black')
        end
       
        @board[0][0] = Rook.new([0, 0], 'black')
        @board[0][7] = Rook.new([0, 7], 'black')
        @board[7][0] = Rook.new([7, 0], 'white')
        @board[7][7] = Rook.new([7, 7], 'white')
    
        @board[0][1] = Knight.new([0, 1], 'black')
        @board[0][6] = Knight.new([0, 6], 'black')
        @board[7][1] = Knight.new([7, 1], 'white')
        @board[7][6] = Knight.new([7, 6], 'white')
    
        @board[0][2] = Bishop.new([0, 2], 'black')
        @board[0][5] = Bishop.new([0, 5], 'black')
        @board[7][2] = Bishop.new([7, 2], 'white')
        @board[7][5] = Bishop.new([7, 5], 'white')
    
        @board[0][3] = King.new([0, 3], 'black')
        @board[7][3] = King.new([7, 3], 'white')
    
        @board[0][4] = Queen.new([0, 4], 'black')
        @board[7][4] = Queen.new([7, 4], 'white')    
      end

      def raw_board
        @board
      end
end

