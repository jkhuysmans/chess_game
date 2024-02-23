class King < ChessPieces
  
    def initialize(position, color, board)
      super(position, color) 
      @name = "K" 
    end
  
    def name
      @name
    end
  
    def moves
      x, y = @position
  
      base_moves = [[x - 1, y - 1], [x, y - 1], [x + 1, y - 1], [x - 1, y], [x + 1, y],
      [x - 1, y + 1], [x, y + 1], [x + 1, y + 1]]
      
      base_moves
    end
end