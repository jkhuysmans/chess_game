class Knight < ChessPieces
  attr_reader :name, :id, :point_value
  
    def initialize(position, color, board)
      super(position, color) 
      @name = color != "white" ? "\u2658" : "\u265E"
      @id = "N"
      @point_value = 3
    end
  
    def moves
      x, y = @position
  
        base_moves = [[x - 1, y - 2], [x - 1, y + 2], [x + 1, y - 2], [x + 1, x + 2],
      [x - 2, y - 1], [x - 2, y + 1], [x + 2, y - 1], [x + 2, x + 1]] 
      
      base_moves
    end
  
end
