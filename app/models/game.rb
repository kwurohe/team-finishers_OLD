class Game < ApplicationRecord
  has_many :user_games
  has_many :users
  has_many :pieces
  has_many :moves

  def piece_present(x_pos, y_pos)
    pieces.where(x_pos: x_pos, y_pos: y_pos).first
  end

end
