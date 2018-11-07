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

  # move_to! method calls valid_move? and will update a piece instance's
  # position and/or capture by setting positions to null. Could update
  # this later to incorporate a piece status
  
  def move_to!(x_new, y_new)
    return raise "Invalid move" if !valid_move?(x_new, y_new)
    occupant = game.piece_present(x_new, y_new)
    current_piece = game.pieces.where(x_pos: x_pos, y_pos: y_pos).first
    if occupant.nil?
      current_piece.update_attributes(x_pos: x_new, y_pos: y_new)
    elsif occupant.color != current_piece.color
      current_piece.update_attributes(x_pos: x_new, y_pos: y_new)
      occupant.update_attributes(x_pos: nil, y_pos: nil)
    else return raise "Invalid move"
    end
  end
end
