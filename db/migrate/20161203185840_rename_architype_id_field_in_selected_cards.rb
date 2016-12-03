class RenameArchitypeIdFieldInSelectedCards < ActiveRecord::Migration[5.0]
  def change
    rename_column :selected_cards, :architype_id, :archetype_id
  end
end
