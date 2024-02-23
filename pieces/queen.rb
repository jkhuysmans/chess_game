require './chess_board_debug.rb'
require './chess_board.rb'

class Queen < ChessPieces
  
    def initialize(position, color, board)
      super(position, color) 
      @name = "Q"
      @board = board 
      @point_value = 9
    end
  
    def name
      @name
    end

    def point_value
      @point_value
    end
  
    def moves
      x, y = @position
      base_moves = []

      1.upto(7) do |i|
        new_x = x - i
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
    
      1.upto(7) do |i|
        new_x = x - i
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
        new_x = x + i
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
        new_x = x + i
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
