class CreatePieces < ActiveRecord::Migration[5.1]
  def change
    create_table :pieces do |t|
      t.integer :game_id
      t.integer :user_id
      t.string :piece_type
      t.boolean :color
      t.integer :current_row
      t.integer :current_column
      t.timestamps
    end
    
  end
end
