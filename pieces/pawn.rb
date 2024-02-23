class Pawn < ChessPieces
  attr_accessor :en_passant
  
    def initialize(position, color, board)
      super(position, color) 
      @name = "P" 
      @moves_number = 0
      @board = board 
      @point_value = 1
      @en_passant = false
    end
  
    def name
      @name
    end

    def point_value
      @point_value
    end

    def moves_number
      @moves_number += 1
    end
  
    def moves
      x, y = @position
      base_moves = []
      direction = color == 'black' ? 1 : -1 

      forward_one = [x + direction, y]
      if @board.board[forward_one[0]][forward_one[1]].nil?
        base_moves << forward_one
        if @moves_number.zero?
          forward_two = [x + 2 * direction, y]
          base_moves << forward_two if @board.board[forward_two[0]][forward_two[1]].nil?
        end
      end
    
      [-1, 1].each do |dy|
        capture_pos = [x + direction, y + dy]
        if capture_pos.all? { |coord| coord.between?(0, 7) }
          target = @board.board[capture_pos[0]][capture_pos[1]]
          if target && target.color != self.color
            base_moves << capture_pos
          end
      end
      
      end

      puts "HEY" if @en_passant == true
      if @en_passant == true
        if @board.board[x][y + 1] && @board.board[x][y + 1].name == "P"
          p @board.board[x][y + 1].position
          base_moves << [x, y + 1]
        end
        if @board.board[x][y - 1] && @board.board[x][y - 1].name == "P"
          p @board.board[x][y - 1].position
          base_moves << [x, y - 1]
        end

        
      end

      p base_moves
      base_moves
    end
    
  end
