class King < Piece
  def valid_move?(x_new, y_new)
    # pulls the distance of the new space from
    # the user's selected space
    x_diff = x_diff(x_new)
    y_diff = y_diff(y_new)
    
    # returns true if move is only one space to
    # left / right / up / down, as king can move
    if x_diff == 1 && y_diff == 1
      return true
    end
    
    # if it's not a legal king move, returns false
    return false
  end
end