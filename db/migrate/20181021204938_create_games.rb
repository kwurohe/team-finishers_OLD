class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer :game_id
      t.integer :turn_time
      t.datetime :start_time
      t.integer :turn_user_id
      t.integer :black_player_user_id
      t.integer :white_player_user_id

      t.timestamps
    end
  end
end
