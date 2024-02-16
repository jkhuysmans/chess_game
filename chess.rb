class ChessPieces
    attr_accessor :position, :color

    def initialize(position, color)
        @position = position 
        @color = color
    end
end

class Pawn < ChessPieces
    def initialize
        if moves_number < 1
            @moves = [[2, 0], [1, 0]]
        else
            @moves = [[1, 0]]
        end
    end
end

class Knights < ChessPieces
    def initialize
        @moves = [
        [-1, -2], [-1, 2], [1, -2], [1, 2],
        [-2, -1], [-2, 1], [2, -1], [2, 1]
      ]
    end
end

class King < ChessPieces
    def moves
        @moves = [[-1, -1], [-1, 1], [1, -1], [1, 1], [0, 1], [0, -1], [1, 0], [1, -1]]
    end
end

class Bishop < ChessPiece
    def moves
      @moves = generate_moves
    end
  
    def generate_moves
      moves = []
  
      directions = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  
      directions.each do |dx, dy|
        1.upto(7) do |i| 
          new_move = [@position[0] + dx * i, @position[1] + dy * i]
          
          if new_move.all? { |coordinate| coordinate.between?(0, 7) }
            moves << new_move
          else
            break 
          end
        end
      end
  
      moves
    end
end

class Rock < ChessPiece
    def moves
      @moves = generate_moves
    end
  
    def generate_moves
      moves = []
  
      directions = [[0, 1], [0, -1], [1, 0], [1, -1]]
  
      directions.each do |dx, dy|
        1.upto(7) do |i| 
          new_move = [@position[0] + dx * i, @position[1] + dy * i]
          
          if new_move.all? { |coordinate| coordinate.between?(0, 7) }
            moves << new_move
          else
            break 
          end
        end
      end
  
      moves
    end
end

class Queen < ChessPiece
    def moves
      @moves = generate_moves
    end
  
    def generate_moves
      moves = []
  
      directions = [[-1, -1], [-1, 1], [1, -1], [1, 1], [0, 1], [0, -1], [1, 0], [1, -1]]
  
      directions.each do |dx, dy|
        1.upto(7) do |i| 
          new_move = [@position[0] + dx * i, @position[1] + dy * i]
          
          if new_move.all? { |coordinate| coordinate.between?(0, 7) }
            moves << new_move
          else
            break 
          end
        end
      end
  
      moves
    end
end
  

