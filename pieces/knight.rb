class Knight < ChessPieces
  
    def initialize(position, color, board)
      super(position, color) 
      @name = "N" 
      @point_value = 3
    end
  
    def name
      @name
    end

    def point_value
      @point_value
    end
  
    def moves
      x, y = @position
  
        base_moves = [[x - 1, y - 2], [x - 1, y + 2], [x + 1, y - 2], [x + 1, x + 2],
      [x - 2, y - 1], [x - 2, y + 1], [x + 2, y - 1], [x + 2, x + 1]] 
      
      base_moves
    end
  
end
