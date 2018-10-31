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

  # NOT TESTED
  def is_obstructed?(x_new, y_new)
    move_direction = move_type(x_new, y_new)
    pieces_in_row = game.pieces.where(x_pos: x_new)
    pieces_in_column = game.pieces.where(y_pos: y_new)
    # horizontal case
    if move_direction == :horizontal
      obstructors = pieces_in_row.where('x_new > ? AND x_new < ?', [x_pos, x_new].min, [x_pos, x_new].max)
      return false if obstructors.nil?
    # vertical case
    elsif move_direction == :vertical
      obstructors = pieces_in_column.where('y_new > ? AND y_new < ?', [y_pos, y_new].min, [y_pos, y_new].max)
      return false if obstructors.nil?
    # diagonal case
    elsif move_direction == :diagonal
      obstructors = []
      (x_pos..x_new).each do |x|
        next if x == x_pos
        break if x == x_new
        (y_pos..y_new).each do |y|
        next if y == y_pos
        break if y == y_new
          return false if game.pieces.where(x_pos: x, y_pos: y) 
        end
      end
    true
  end
end
