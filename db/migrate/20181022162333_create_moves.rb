class CreateMoves < ActiveRecord::Migration[5.1]
  def change
    create_table :moves do |t|
      t.integer :game_id
      t.integer :user_id
      t.integer :piece_id
      t.integer :vertical_end
      t.integer :horizontal_end
      t.integer :current_row
      t.integer :current_column
      t.timestamps
    end
  end
end
