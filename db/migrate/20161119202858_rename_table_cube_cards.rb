class RenameTableCubeCards < ActiveRecord::Migration[5.0]
  def change
    rename_table :cards_cubes, :selected_cards
  end
end
