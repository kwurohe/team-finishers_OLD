class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :moves

  def valid_move?(x_new, y_new)
    true
  end

  def is_obstructed?
    
    true
  end
end
