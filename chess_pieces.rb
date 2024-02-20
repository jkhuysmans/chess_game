class ChessPieces
    attr_accessor :position, :color

    def initialize(position, color)
        @position = position 
        @color = color
    end
end

class King < ChessPieces

  def initialize(position, color)
    super(position, color) 
    @name = "K" 
  end

  def name
    @name
  end

    def moves
        @moves = [[-1, -1], [-1, 1], [1, -1], [1, 1], [0, 1], [0, -1], [1, 0], [1, -1]]
    end
end

class Bishop < ChessPieces
  def initialize(position, color)
    super(position, color) 
    @name = "B" 
  end

  def name
    @name
  end
  
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

class Rook < ChessPieces
  
  def initialize(position, color)
    super(position, color) 
    @name = "R" 
  end

  def name
    @name
  end

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

class Queen < ChessPieces

  def initialize(position, color)
    super(position, color) 
    @name = "Q" 
  end

  def name
    @name
  end

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


  

