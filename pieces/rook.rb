require './chess_board_debug.rb'
require './chess_board.rb'

class Rook < ChessPieces
  attr_reader :name, :id, :point_value
  
    def initialize(position, color, board)
      super(position, color) 
      @name = color == "white" ? "\u2656" : "\u265C"
      @board = board
      @id = "R"
      @point_value = 5
    end
  
    def moves
      x, y = @position
      base_moves = []
  
      1.upto(7) do |i|
        new_x = x - i
        new_y = y
      
        break unless new_x.between?(0, 7) && new_y.between?(0, 7)
      
        cell = @board.board[new_x][new_y] 

        if cell
          base_moves << [new_x, new_y] if cell.color != @color
          break
        else
          base_moves << [new_x, new_y]
        end
      end
      
  
      1.upto(7) do |i|
        new_x = x + i
        new_y = y
      
        break unless new_x.between?(0, 7) && new_y.between?(0, 7)
      
        cell = @board.board[new_x][new_y] 

        if cell
          base_moves << [new_x, new_y] if cell.color != @color
          break
        else
          base_moves << [new_x, new_y]
        end
      end
  
      1.upto(7) do |i|
        new_x = x
        new_y = y + i
      
        break unless new_x.between?(0, 7) && new_y.between?(0, 7)
      
        cell = @board.board[new_x][new_y] 

        if cell
          base_moves << [new_x, new_y] if cell.color != @color
          break
        else
          base_moves << [new_x, new_y]
        end
      end
  
      1.upto(7) do |i|
        new_x = x
        new_y = y - i
      
        break unless new_x.between?(0, 7) && new_y.between?(0, 7)
      
        cell = @board.board[new_x][new_y] 

        if cell
          base_moves << [new_x, new_y] if cell.color != @color
          break
        else
          base_moves << [new_x, new_y]
        end
      end

      base_moves
    end
end
