class King < ChessPieces
  attr_reader :name, :id, :point_value
  
    def initialize(position, color, board)
      super(position, color) 
      @name = color != "white" ? "\u2654" : "\u265A"
      @id = "K"
      @point_value = 100 
      @in_check = false
    end

    def in_check
      @in_check
    end

    def set_in_check
      @in_check = true
    end
  
    def moves
      x, y = @position
  
      base_moves = [[x - 1, y - 1], [x, y - 1], [x + 1, y - 1], [x - 1, y], [x + 1, y],
      [x - 1, y + 1], [x, y + 1], [x + 1, y + 1]]

      base_moves = base_moves.select do |new_x, new_y|
        new_x.between?(0, 7) && new_y.between?(0, 7)
      end
      
      base_moves
    end
end