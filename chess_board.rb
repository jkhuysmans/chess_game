require './chess_pieces.rb'

Dir.glob(File.join(__dir__, 'pieces', '*.rb')).each do |file|
    require_relative file
  end


class ChessBoard
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
                    column.nil? ? "." : column.name
                end
            end.join(" ")
          end.join("\n")
    end

    def setup_pieces
      # White pieces
      @board[7][0] = Rook.new([7, 0], 'white', self)
      @board[7][1] = Knight.new([7, 1], 'white', self)
      @board[7][2] = Bishop.new([7, 2], 'white', self)
      @board[7][3] = Queen.new([7, 3], 'white', self)
      @board[7][4] = King.new([7, 4], 'white', self)
      @board[7][5] = Bishop.new([7, 5], 'white', self)
      @board[7][6] = Knight.new([7, 6], 'white', self)
      @board[7][7] = Rook.new([7, 7], 'white', self)
      8.times { |i| @board[6][i] = Pawn.new([6, i], 'white', self) }
      
      # Black pieces
      @board[0][0] = Rook.new([0, 0], 'black', self)
      @board[0][1] = Knight.new([0, 1], 'black', self)
      @board[0][2] = Bishop.new([0, 2], 'black', self)
      @board[0][3] = Queen.new([0, 3], 'black', self)
      @board[0][4] = King.new([0, 4], 'black', self)
      @board[0][5] = Bishop.new([0, 5], 'black', self)
      @board[0][6] = Knight.new([0, 6], 'black', self)
      @board[0][7] = Rook.new([0, 7], 'black', self)
      8.times { |i| @board[1][i] = Pawn.new([1, i], 'black', self) }
    end
    

      def raw_board
        @board
      end
end

