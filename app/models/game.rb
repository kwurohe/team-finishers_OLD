class Game < ApplicationRecord
  has_many :user_games
  has_many :users
  has_many :pieces
  has_many :moves

  scope :available, -> { where("black_player_user_id is null or white_player_user_id is null") }
  after_create :populate_game!

def populate_game!
  create_white_pieces if self.white_player_user_id
  create_black_pieces if self.black_player_user_id
end


def create_white_pieces
  8.times do |i|
    Pawn.create(
      :user_id => white_player_user_id,
      :game_id => self.id,
      :current_row => 1,
      :current_column => i,
      :color => true
    )
  end
  Rook.create(
    :user_id => white_player_user_id,
    :game_id => self.id,
    :current_row => 0,
    :current_column => 0,
    :color => true
  )
  Rook.create(
    :user_id => white_player_user_id,
    :game_id => self.id,
    :current_row => 0,
    :current_column => 7,
    :color => true
  )
  Knight.create(
    :user_id => white_player_user_id,
    :game_id => self.id,
    :current_row => 0,
    :current_column => 1,
    :color => true
  )
  Knight.create(
    :user_id => white_player_user_id,
    :game_id => self.id,
    :current_row => 0,
    :current_column => 6,
    :color => true
  )
  Bishop.create(
    :user_id => white_player_user_id,
    :game_id => self.id,
    :current_row => 0,
    :current_column => 2,
    :color => true
  )
  Bishop.create(
    :user_id => white_player_user_id,
    :game_id => self.id,
    :current_row => 0,
    :current_column => 5,
    :color => true
  )
  Queen.create(
    :user_id => white_player_user_id,
    :game_id => self.id,
    :current_row => 0,
    :current_column => 3,
    :color => true
  )
  King.create(
    :user_id => white_player_user_id,
    :game_id => self.id,
    :current_row => 0,
    :current_column => 4,
    :color => true
  )
end


def create_black_pieces
  8.times do |y|
    Pawn.create(
      :user_id => black_player_user_id,
      :game_id => self.id,
      :current_row => 6,
      :current_column => y,
      :color => false
    )
  end
  Rook.create(
    :user_id => black_player_user_id,
    :game_id => self.id,
    :current_row => 7,
    :current_column => 0,
    :color => false
  )
  Rook.create(
    :user_id => black_player_user_id,
    :game_id => self.id,
    :current_row => 7,
    :current_column => 7,
    :color => false
  )
  Knight.create(
    :user_id => black_player_user_id,
    :game_id => self.id,
    :current_row => 7,
    :current_column => 1,
    :color => false
  )
  Knight.create(
    :user_id => black_player_user_id,
    :game_id => self.id,
    :current_row => 7,
    :current_column => 6,
    :color => false
  )
  Bishop.create(
    :user_id => black_player_user_id,
    :game_id => self.id,
    :current_row => 7,
    :current_column => 2,
    :color => false
  )
  Bishop.create(
    :user_id => black_player_user_id,
    :game_id => self.id,
    :current_row => 7,
    :current_column => 5,
    :color => false
  )
  Queen.create(
    :user_id => black_player_user_id,
    :game_id => self.id,
    :current_row => 7,
    :current_column => 3,
    :color => false
  )
  King.create(
    :user_id => black_player_user_id,
    :game_id => self.id,
    :current_row => 7,
    :current_column => 4,
    :color => false
  )
end


end
