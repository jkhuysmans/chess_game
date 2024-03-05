class Pawn < ChessPieces
  attr_accessor :en_passant, :moves_number
  attr_reader :name, :id, :point_value, :board
  
    def initialize(position, color, board)
      super(position, color) 
      @name = color == "white" ? "\u2659" : "\u265F"
      @id = "P"
      @moves_number = 0
      @board = board 
      @point_value = 1
      @en_passant = false
    end

    def increment_moves
      @moves_number += 1
    end

    def set_en_passant
      @en_passant = true
    end

    def en_passant
      @en_passant
    end
  
    def moves
      x, y = @position
      base_moves = []
      direction = @color == "white" ? -1 : 1

      base_moves << [x + direction, y]
      base_moves << [x + direction * 2, y] if @moves_number <= 1
      
      base_moves
    end
    
  end