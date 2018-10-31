class Game < ApplicationRecord
  has_many :user_games
  has_many :users
  has_many :pieces
  has_many :moves

  scope :available, -> { where('black_player_user_id = null').or(where('white_player_user_id = null')) } 
end
