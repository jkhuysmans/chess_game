class Pawn < ChessPieces
  attr_accessor :en_passant, :moves_number
  attr_reader :name, :id, :point_value, :en_passant_round, :board
  
    def initialize(position, color, board)
      super(position, color) 
      @name = color == "white" ? "\u2659" : "\u265F"
      @id = "P"
      @moves_number = 0
      @board = board 
      @point_value = 1
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