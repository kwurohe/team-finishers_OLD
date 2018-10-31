class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :moves

  def is_obstructed?(piece, column, row)
  	# This method is designed to work within an 8x8 grid (standard chess board) where the bottom left corner is (0,0) and the top right corner is (8,8)
  	# The first digit in the coordinate pair is the column (vertical) and the second digit is the row (horizontal)
  	# It takes a Piece object, as well as a column coordinate (x-axis) and a row cooridnate (y-axis)
  	# It returns true if a move is obstructed between the start and end point 
  	# It does NOT RETURN TRUE IF AN END POINT IS OBSTRUCTED

    # Check if move is off board
    if column > 7 || column < 0 || row > 7 || row < 0
      return true
    end

    # Special condition for Knight that always returns false
    if piece.instance_of?(Knight) 
    	return false
    end

    # Testing if move is not on a diagonal, horizontal, or vertical, i.e. not a straight-line move
    if piece.current_column - column).abs != (piece.current_row - row).abs #diagonal test
    	if piece.current_column - column != 0 && piece.current_row != current_row #horizontal test
    		if piece.current_row - row != 0 && piece.current_column != current_column #vertical test
    			return true
    		end
    	end
    end

    # Build an array of all the pieces in the current game
    pieces = game.pieces

    # Use the pieces array to build an array of all the occupied spaces in the game
    occupied_spaces = []
    pieces.each do |p|
    	occupied_spaces << [p.current_column, p.current_row]
    end 

    # Build an array of the spaces in the move
    move_spaces = []
    current_column = piece.current_column
    current_row = piece.current_row

    while current_column != column || current_row != row
        if current_column - column < 0
          current_column += 1 #move right
        elsif current_column - column > 0
          current_column -= 1  #move left
        end

        if current_row - row < 0
          current_row += 1  #move up
        elsif current_row - row > 0
          current_row -= 1 #move down
        end

      move_spaces << [current_column, current_row]
    end

    # Removing the last element from move_spaces array. This last element would be the space you land on, so it doesn't matter if there is another piece there, you would just take it.
		move_spaces.delete_at(move_spaces.length-1)

    # Check whether any occupied spaces or spaces in move overlap (are common)
    overlap =  occupied_spaces & move_spaces
    overlap.length > 0 ? true : false

  end

end
