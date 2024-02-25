    # Methods for the pawn's special rules

def reset_en_passant_flags
    @board.board.each do |row|
      row.each do |piece|
        piece.en_passant_increment if piece.is_a?(Pawn) && piece.en_passant == true
        puts "en passant round: #{piece.en_passant_round}" if piece.is_a?(Pawn) && piece.en_passant == true
        if piece.is_a?(Pawn) && piece.en_passant_round == 3
            piece.en_passant = false
        end
      end
    end
  end     

def check_en_passant(piece, old_position, target_position)
    if piece.is_a?(Pawn) && (old_position[0] - target_position[0]).abs == 2
        piece.en_passant = true
    end
end

def pawn_promotion(piece)
    if piece.position[0] == 7
      player = piece.color == "white" ? @white : @black

      filtered_items = player[1].reject { |item| item == "Pawn" }
        puts "You can promote your pawn! You can choose among: #{filtered_items.join(", ")}."

        promotion_input = nil
        until filtered_items.include?(promotion_input)
          promotion_input = gets.chomp.to_s
          unless filtered_items.include?(promotion_input)
            puts "Invalid input! Please choose among: #{filtered_items.join(", ")}"
          end
        end

        @board.board[piece.position[0]][piece.position[1]] = Object.const_get(promotion_input).new([piece.position[0]][piece.position[1]], "#{piece.color}", self)
    end
end

  #In check & checkmate

  def king_in_check?
    pieces_on_board = []
    king_piece = nil

    @board.board.each do |row|
      row.each do |piece|
        pieces_on_board << piece if !piece.nil? && piece.class != King
        king_piece = piece if piece.class == King
      end
    end

    pieces_on_board.each do |piece|
      if piece.moves.include?(king_piece.position) && piece.color != king_piece.color
        puts "King is in check!"
        checkmate?(king_piece, pieces_on_board)
        break
      end
    end
  
  end

  def checkmate?(king_piece, pieces_on_board)

    can_move_king?(king_piece, pieces_on_board)
    
  end

  def can_move_king?(king_piece, pieces_on_board)

    king_piece.moves.each do |move|
      move_is_safe = true
  
      pieces_on_board.each do |piece|
        if piece.color != king_piece.color && piece.moves.include?(move)
          move_is_safe = false
          break
        end
      end
  
      if move_is_safe
        puts "true"
        # @board.board[move[0]][move[1]] = "O"
        # return true
      end
    end
  
    puts "false"
    return false
  end