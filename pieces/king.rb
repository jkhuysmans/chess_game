class King < ChessPieces
  attr_reader :name, :id, :point_value
  
    def initialize(position, color, board)
      super(position, color) 
      @name = color != "white" ? "\u2654" : "\u265A"
      @id = "K"
      @point_value = 100 
    end
  
    def moves
      x, y = @position
  
      base_moves = [[x - 1, y - 1], [x, y - 1], [x + 1, y - 1], [x - 1, y], [x + 1, y],
      [x - 1, y + 1], [x, y + 1], [x + 1, y + 1]]
      
      base_moves
    end
end