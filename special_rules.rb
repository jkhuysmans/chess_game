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