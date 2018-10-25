class RenameColumnPieceTypeinCreatePiecestoType < ActiveRecord::Migration[5.1]
  def change
    rename_column :pieces, :piece_type, :type
  end
end
