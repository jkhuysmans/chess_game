require './chess_pieces.rb'

Dir.glob(File.join(__dir__, 'pieces', '*.rb')).each do |file|
    require_relative file
  end


class ChessBoardDebug
    attr_accessor :board

    def initialize(game)
        @game = game
        @board = Array.new(8) { Array.new(8) }
        setup_pieces
    end

    def display
        display_board = Marshal.load(Marshal.dump(@board))
        display_board.push(["a", "b", "c", "d", "e", "f", "g", "h"])

        numbers = [" ", 1, 2, 3, 4, 5, 6, 7, 8].reverse
        # letters = ["a", "b", "c", "d", "e", "f", "g", "h", " "]
        # numbers = [0, 1, 2, 3, 4, 5, 6, 7, " "]


        display_board.map.with_index do |row, index|
            row.unshift(numbers[index])
        end

        black_stats = @game.instance_variable_get(:@black)
        white_stats = @game.instance_variable_get(:@white)
        display_board[1].push "   Black's points: #{black_stats[0]}"
        display_board[2].push "   White's points: #{white_stats[0]}"
        
       

        display_board.map.with_index do |row|
            row.map do |column|

                if column.is_a?(String) || column.is_a?(Numeric)
                    column.to_s
                else
                    column.nil? ? "." : column.id
                end
            end.join(" ")
          end.join("\n")
    end

    def setup_pieces
        
          @board[7 - 5][4] = King.new([7 - 5, 4], 'black', self)   # Black King at e5 (standard chess notation)
          @board[7 - 3][7] = Queen.new([7 - 4, 7], 'white', self) # White Queen at h5
          @board[7 - 7][4] = Rook.new([7 - 7, 4], 'white', self)  # White Rook at e8
          @board[7 - 2][2] = Bishop.new([7 - 1, 1], 'white', self) # White Bishop at b2
          @board[7 - 4][2] = Knight.new([7 - 4, 2], 'white', self) # White Knight at c4
          @board[7 - 4][6] = Knight.new([7 - 4, 6], 'white', self) # White Knight at g4
          @board[7 - 5][3] = Pawn.new([7 - 5, 3], 'white', self)   # White Pawn at d6
          @board[7 - 5][5] = Pawn.new([7 - 5, 5], 'white', self)   # White Pawn at f6
          
         
      end

      def raw_board
        @board
      end
end

