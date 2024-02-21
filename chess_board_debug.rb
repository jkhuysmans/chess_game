require './chess_pieces.rb'

Dir.glob(File.join(__dir__, 'pieces', '*.rb')).each do |file|
    require_relative file
  end


class ChessBoardDebug
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
        
          @board[6][6] = Knight.new([6, 6], 'white', self)
          @board[2][2] = Queen.new([2, 2], 'black', self)
          
      end

      def raw_board
        @board
      end
end

