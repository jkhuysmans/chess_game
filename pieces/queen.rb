require './chess_board_debug.rb'
require './chess_board.rb'

class Queen < ChessPieces
  
    def initialize(position, color, board)
      super(position, color) 
      @name = "Q"
      @board = board 
    end
  
    def name
      @name
    end
  
    def moves
      x, y = @position
      base_moves = []
  
      1.upto(7) do |i|
        new_x = x - i
        new_y = y - i
      
        break if new_x < 0 || new_y < 0
      
        cell = @board.board[new_x][new_y] 
      
        break unless cell.nil?
      
        base_moves << [new_x, new_y]
      end
      
  
      1.upto(7) do |i|
        new_x = x - i
        new_y = y + i
      
        break if new_x < 0 || new_y < 0
      
        cell = @board.board[new_x][new_y] 
      
        break unless cell.nil?
      
        base_moves << [new_x, new_y]
      end
  
      1.upto(7) do |i|
        new_x = x + i
        new_y = y + i
      
        break if new_x < 0 || new_y < 0
      
        cell = @board.board[new_x][new_y] 
      
        break unless cell.nil?
      
        base_moves << [new_x, new_y]
      end
  
      1.upto(7) do |i|
        new_x = x + i
        new_y = y - i
      
        break if new_x < 0 || new_y < 0
      
        cell = @board.board[new_x][new_y] 
      
        break unless cell.nil?
      
        base_moves << [new_x, new_y]
      end

      1.upto(7) do |i|
        new_x = x - i
        new_y = y
      
        break if new_x < 0 || new_y < 0 || new_x > 7 || new_y > 7
      
        cell = @board.board[new_x][new_y] 
        break unless cell.nil?
      
        base_moves << [new_x, new_y]
      end
      
  
      1.upto(7) do |i|
        new_x = x + i
        new_y = y
      
        break if new_x < 0 || new_y < 0 || new_x > 7 || new_y > 7
      
        cell = @board.board[new_x][new_y] 
        break unless cell.nil?
      
        base_moves << [new_x, new_y]
      end
  
      1.upto(7) do |i|
        new_x = x
        new_y = y + i
      
        break if new_x < 0 || new_y < 0 || new_x > 7 || new_y > 7
      
        cell = @board.board[new_x][new_y] 
        break unless cell.nil?
      
        base_moves << [new_x, new_y]
      end
  
      1.upto(7) do |i|
        new_x = x
        new_y = y - i
      
        break if new_x < 0 || new_y < 0 || new_x > 7 || new_y > 7
      
        cell = @board.board[new_x][new_y] 
        break unless cell.nil?
      
        base_moves << [new_x, new_y]
      end

      base_moves
    end
end
