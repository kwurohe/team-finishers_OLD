class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :moves

  def is_obstructed?(piece, column, row)
  	# This method is designed to work within an 8x8 grid (standard chess board) where the bottom left corner is (0,0) and the top right corner is (8,8)
  	# The first digit in the coordinate pair is the column (vertical) and the second digit is the row (horizontal)

    #check if move is off board
    if column > 8 || column < 0 || row > 8 || row < 0
      true
    end

    #build an array of all the pieces in the current game
    pieces = piece.game.pieces

    #use the pieces array to build an array of all the occupied spaces in the game
    occupied_spaces = []
    pieces.each do |piece|
    	occupied_spaces << [piece.current_column, piece.current_row]
    end 

    #build an array of the spaces in the move
    move_spaces = []
    current_column = piece.column
    current_row = piece.row

    while current_column != column && current_row != row
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

    #check whether any occupied spaces or spaces in move overlap (are common)
    overlap =  occupied_spaces & move_spaces
    overlap.length > 0 ? true : false


  end

end
