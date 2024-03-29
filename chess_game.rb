require './chess_board.rb'
require './chess_board_debug.rb'
require './chess_pieces.rb'
require './special_rules.rb'
require './save_game.rb'

class ChessGame

    def initialize
        @board = ChessBoard.new(self)
        @white = [0, []]
        @black = [0, []]
        @round = 1
        @archived_boards = []
        @draw_possible = true
        @game_over = false
    end

    def display
        puts "#{@board.display}", " "
    end

    def start
        round
    end

    def round
        if @game_over
            return
            replay
        end

        if @round.odd?
            current_player_color = "white"
        elsif @round.even?
            current_player_color = "black"
        end

        puts "Round #{@round}. This is #{current_player_color}'s turn:"
        display

        check_draw?(current_player_color)

        checkmate?

        select_piece(current_player_color)
    end 

    def selection_valid?(selected_piece)
        return "Invalid input, please enter a valid selection (e.g. 'a7', 'b5', etc)" if selected_piece.nil? || selected_piece.length != 2
        
        unless selected_piece.match?(/\A[a-h][1-8]\z/i)
          return "Invalid input, please enter a valid selection (e.g. 'a7', 'b5', etc)"
         end
      
        position = convert_selection(selected_piece)
        unless (0..7).include?(position[0]) && (0..7).include?(position[1])
          return "Invalid input, please input something within the scope of the board"
        end
      
        true
    end
      
    def convert_selection(selected_piece)
        column = selected_piece[0].downcase.ord - 'a'.ord
        row = 9 - selected_piece[1].to_i - 1

        return [row, column]
    end
      
    def select_piece(current_player_color)
        puts "#{current_player_color.capitalize} player, please enter your selection:"
        
        loop do
            selected_piece = gets.chomp

            if selected_piece.downcase == "draw" && @draw_possible
                break if draw_input(current_player_color)
            elsif selected_piece.downcase == "save"
                save_game
            elsif selected_piece.downcase == "exit"
                intro
                return
            else
                result = selection_valid?(selected_piece)
            end
            
            if result == true
                piece_position = convert_selection(selected_piece)
                piece = @board.board[piece_position[0]][piece_position[1]]
                input_move_piece(piece, current_player_color)
                break
            else
                puts result
            end
        end
    end

    def valid_move?(emplacement, piece, target_position, possible_moves)
        valid_check = selection_valid?(emplacement)
        return valid_check if valid_check.is_a?(String)

        unless possible_moves.include?(target_position)
          return "Target position is not within the piece's possible moves."
        end
    
        target_piece = @board.board[target_position[0]][target_position[1]]
        
        if target_piece && piece.color == target_piece.color
          return "You cannot capture a piece of the same color."
        end
    
        true
    end

    def input_move_piece(piece, current_player_color)
        puts "You selected a #{piece.class}. Where do you want to put the piece? Input 'cancel' to cancel your selection."
            possible_moves = piece.moves
            special_moves = check_for_special_moves(piece)
            possible_moves += special_moves unless special_moves.empty?

            loop do
                emplacement = gets.chomp.downcase

                if emplacement == "cancel"
                    puts "Cancelled input"
                    select_piece(current_player_color)
                    break
                end

                old_position = piece.position
                
                if selection_valid?(emplacement) 
                    target_position = convert_selection(emplacement)

                    result = valid_move?(emplacement, piece, target_position, possible_moves)

                    if result == true
                        move_piece(old_position, piece, current_player_color, target_position)
                        sleep(1)
                        round
                        break
                    else
                        puts result
                    end
                else
                    puts "Invalid move. Please try again."
                end
            end
    end

    def move_piece(old_position, piece, current_player_color, target_position)
        @board.board[old_position[0]][old_position[1]] = nil
        check_if_capture_piece(piece, old_position, target_position, current_player_color)
                        
        @board.board[target_position[0]][target_position[1]] = piece 
        piece.position = target_position

        puts "Move valid. Piece moved."
        check_pawn(piece, old_position, target_position) if piece.id == "P"
        add_round
    end

    def add_round
        @round += 1
    end

    def check_pawn(piece, old_position, target_position)
        piece.increment_moves
        piece.set_en_passant if piece.moves_number == 1 && (old_position[0] - target_position[0]).abs == 2
        
        pawn_promotion(piece)
    end

    def check_if_capture_piece(piece, old_position, target_position, current_player_color)
        target = @board.board[target_position[0]][target_position[1]]

        if target != nil && target.color != current_player_color
            capture_piece(piece, target, current_player_color)
        end

        increment = piece.color == "white" ? -1 : 1
        under_cell = @board.board[target_position[0] - increment][target_position[1]]

        if under_cell.class == Pawn && under_cell.color != piece.color 
            capture_piece(piece, under_cell, current_player_color) if under_cell.en_passant == true
            @board.board[target_position[0] - increment][target_position[1]] = nil
        end

    end

    def capture_piece(piece, target, current_player_color)
        puts "Piece captured!"

        if current_player_color == "white"
            @white[0] += target.point_value
            @white[1] << target.name
        else
            @black[0] += target.point_value
            @black[1] << target.name
        end

        end_checkmate(piece) if target.name == "K"
    end

    def end_checkmate(piece)
        puts "Checkmate! #{piece.color.capitalize} wins!"
        @game_over = true
    end

    def end_stalemate(piece)
        puts "Stalemate!"
        @game_over = true
    end

    def end_by_draw
        puts "Game ended in a draw!"
        @game_over = true
    end

    def replay
        puts "Would you like to play another game? (yes/no)"

        loop do
            player_input = gets.chomp.to_s.downcase
            
            if other_player_input == "yes"
                intro
            elsif other_player_input == "no"
              puts "Thank you for playing!"
            else
              puts "Invalid input."
            end
          end
    end

end
