    # Methods for the pawn's special rules

def check_for_special_moves(piece)
  special_moves = []
  piece_position = piece.position

  increment = piece.color == "white" ? -1 : 1
  diagonal_left_cell = @board.board[piece_position[0] + increment][piece_position[1] - 1]
  diagonal_right_cell = @board.board[piece_position[0] + increment][piece_position[1] + 1]
  en_passant_moves = en_passant_moves(piece, [piece_position[0] + increment, piece_position[1] - 1], [piece_position[0] + increment, piece_position[1] + 1])

  if !diagonal_left_cell.nil? && diagonal_left_cell.color != piece.color
    special_moves << diagonal_left_cell.position
  end

  if !diagonal_right_cell.nil? && diagonal_right_cell.color != piece.color
    special_moves << diagonal_right_cell.position
  end
 
  special_moves += en_passant_moves unless en_passant_moves.empty?
  special_moves
end

def en_passant_moves(piece, diagonal_left, diagonal_right)
  en_passant_moves = []
  piece_position = piece.position
  left_cell = @board.board[piece_position[0]][piece_position[1] - 1]
  right_cell = @board.board[piece_position[0]][piece_position[1] + 1]
  
  if left_cell.class == Pawn && left_cell.color != piece.color
    en_passant_moves << diagonal_left if left_cell.en_passant == true
  end

  if right_cell.class == Pawn && right_cell.color != piece.color
    en_passant_moves << diagonal_right if right_cell.en_passant == true
  end

  en_passant_moves
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

def king_in_check?(potential_attackers, king)
  potential_attackers.each do |attacker|
    if attacker.moves.include?(king.position) && attacker.color != king.color
      puts "#{king.color.capitalize} King is in check!"
      king.set_in_check
      break
    end
  end
end
  
def checkmate?
  puts "checking checkmate"
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
    potential_attackers = all_pieces.reject { |piece| piece == king if king.color != piece.color }
    king_in_check?(potential_attackers, king)
    can_king_move?(potential_attackers, king)
  end

end

def can_king_move?(potential_attackers, king)
  safe_move_found = false

  other_pieces_moves = []
  potential_attackers.each do |piece|
    if piece.color != king.color
      piece.moves.each do |move|
        other_pieces_moves << move
      end
      other_pieces_moves << piece.position
    end
  end

  other_pieces_moves.each do |move|
       # @board.board[move[0]][move[1]] = Pawn.new([move[0], move[1]], "white", self)
  end

  king.moves.each do |move|
    if !other_pieces_moves.include?(move)
      puts "can move: #{move}"
      safe_move_found = true
    end
  end

  p safe_move_found
  return safe_move_found
end