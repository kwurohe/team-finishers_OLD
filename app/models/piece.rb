class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :moves

  def valid_move?(x_new, y_new)
    true
  end

  def move_type(x_new, y_new)
    # Need to deal with Knight case
    horizontal_delta = (x_new - x_pos).abs
    vertical_delta = (y_new - y_pos).abs

    return :horizontal if horizontal_delta > 0 && vertical_delta.zero?
    return :vertical if vertical_delta > 0 && horizontal_delta.zero?
    return :diagonal if vertical_delta == horizontal_delta
    return :invalid if vertical_delta > 0 && horizontal_delta > 0 && vertical_delta != horizontal_delta && type != "Knight"
  end

  def is_obstructed?(x_new, y_new)
    move_direction = move_type(x_new, y_new)
    pieces_in_row = game.pieces.where(x_pos: x_new)
    pieces_in_column = game.pieces.where(y_pos: y_new)
    # horizontal case
    if move_direction == :horizontal
      return false if pieces_in_row.where("#{x_new} > ? AND #{x_new} < ?", [x_pos, x_new].min, [x_pos, x_new].max).empty?
    # vertical case
    elsif move_direction == :vertical
      return false if pieces_in_column.where("#{y_new} > ? AND #{y_new} < ?", [y_pos, y_new].min, [y_pos, y_new].max).empty?
    # diagonal case
    elsif move_direction == :diagonal
      (x_pos..x_new).each do |x|
        next if x == x_pos
        return false if x == x_new
        (y_pos..y_new).each do |y|
          next if y == y_pos
          return true if game.pieces.where(x_pos: x, y_pos: y).size == 2
        end
      end
    end
    raise "Invalid move" if move_direction == :invalid
  end

  def move_to!(x_new, y_new)
    if game.piece_present(x_new, y_new).nil? && valid_move?(x_new, y_new)
      update_attributes(x_pos: x_new, y_pos: y_new)
    end
  end
end
# This method is important and eventually, we will use it in the controller to handle moving pieces.

# This move_to method should handle the following cases:

#     Check to see if there is a piece in the location it’s moving to.
#     If there is a piece occupying the location, and it is the opposite color, remove the piece from the chess board. This can be done a few different ways.
#         You could have a “status” flag on the piece that will be one of “onboard” or “captured”. Make sure to write the appropriate migration without changing existing migrations.
#     If the piece is there and it’s the same color the move should fail - it should either raise an error message or do nothing.
#     It should call update_attributes on the piece and change the piece’s x/y position.
#     Note: This method does not check if a move is valid. We will be using the valid_move? method to do that.
