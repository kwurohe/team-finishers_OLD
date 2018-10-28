class Move < ApplicationRecord
  belongs_to :game
  belongs_to :piece 

  def is_obstructed?
    
  end
end
