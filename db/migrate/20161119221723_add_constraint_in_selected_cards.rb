class AddConstraintInSelectedCards < ActiveRecord::Migration[5.0]
  def change
    add_index :selected_cards, [:card_id, :cube_id, :architype_id], :unique => true
  end
end
