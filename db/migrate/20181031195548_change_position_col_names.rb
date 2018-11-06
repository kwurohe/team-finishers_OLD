class ChangePositionColNames < ActiveRecord::Migration[5.1]
  def change
    rename_column :pieces, :current_row, :x_pos
    rename_column :pieces, :current_column, :y_pos
  end
end
