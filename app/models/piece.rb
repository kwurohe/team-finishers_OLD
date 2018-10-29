class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :moves



  def is_obstructed?
    
    true
  end
end
