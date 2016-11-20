class AddArchitypeToSelectedCards < ActiveRecord::Migration[5.0]
  def change
    add_reference :selected_cards, :architype, index:true
  end
end
