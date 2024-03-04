    # Methods for the pawn's special rules



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
  all_pieces = []
  king_pieces = []
  
  @board.board.each do |row|
    row.each do |piece|
      next if piece.nil?
      all_pieces << piece
      king_pieces << piece if piece.class == King
    end
  end
  
  king_pieces.each do |king|
    # Temporarily remove the current king from all pieces to get potential attackers
    potential_attackers = all_pieces.reject { |piece| piece == king }
      
    potential_attackers.each do |attacker|
      if attacker.moves.include?(king.position) && attacker.color != king.color
        puts "King is in check!"
        checkmate?(king, potential_attackers)
        break
      end
    end
  end
end
  
def checkmate?(king_piece, pieces_on_board)

  can_king_move?(king_piece, pieces_on_board)
    
end

def can_king_move?(king_piece, pieces_on_board)
  safe_move_found = false

  other_pieces_moves = []
  pieces_on_board.each do |piece|
    if piece.color != king_piece.color
      piece.moves.each do |move|
        other_pieces_moves << move
      end
    end
  end

  other_pieces_moves.each do |move|
       # @board.board[move[0]][move[1]] = Pawn.new([move[0], move[1]], "white", self)
  end

  king_piece.moves.each do |move|
    if !other_pieces_moves.include?(move)
      puts "can move: #{move}"
      safe_move_found = true
    end
  end

  p safe_move_found
  return safe_move_found
end