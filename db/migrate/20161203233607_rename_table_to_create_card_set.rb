class RenameTableToCreateCardSet < ActiveRecord::Migration[5.0]
  def change
    rename_table :archetypes_cards, :cardsets
  end
end
