def position_to_indices(pos)
    column = pos[0].downcase.ord - 'a'.ord
    row = 8 - pos[1].to_i
    p [row, column]
    indices_to_position(row, column)
  end
  
  def indices_to_position(row, column)
    pos = ('a'.ord + column).chr + (8 - row).to_s
    p pos
  end
  
  position_to_indices("a4")


  possible_moves.each do |move|
    @board.board[move[0]][move[1]] = "O"
end
display

possible_moves.each do |move|
  @board.board[move[0]][move[1]] = "0"
end
