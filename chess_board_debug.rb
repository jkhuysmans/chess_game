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

        #first number: column, second number: row
        
          #@board[7 - 7][7] = King.new([7 - 7, 7], 'white', self)
          #@board[7 - 6][5] = King.new([7 - 6, 5], 'black', self)
          #@board[7 - 6][7] = Rook.new([7 - 6, 7], 'black', self)

          @board[7 - 4][4] = Pawn.new([7 - 4, 4], 'white', self)
          @board[7 - 4][3] = Pawn.new([7 - 5, 3], 'black', self)
          @board[7 - 4][5] = Pawn.new([7 - 5, 5], 'black', self)
          @board[7 - 5][3] = Pawn.new([7 - 5, 3], 'black', self)

      end

      def raw_board
        @board
      end
end

