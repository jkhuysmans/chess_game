class Pawn < ChessPieces
  
    def initialize(position, color)
      super(position, color) 
      @name = "P" 
      @moves_number = 0
    end
  
    def name
      @name
    end
  
    def moves
      x, y = @position
  
      if @color == 'black'
        base_moves = [[x + 1, y]] 
        base_moves << [x + 2, y] if @moves_number.zero? 
      else 
        base_moves = [[x - 1, y]]
        base_moves << [x - 2, y] if @moves_number.zero?
      end
  
      @moves_number += 1
      base_moves
    end
  
end
