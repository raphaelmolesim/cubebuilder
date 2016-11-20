class Cube < ApplicationRecord
  
  has_many :selected_cards
  
  def sync_all_cube cube_list
    cube_list.each do |card|
      card[:architypes].each do |architype_id|
        selected_card = selected_cards.detect { |c| 
          c.card_id == card[:id] && c.architype_id == architype_id  }
        if selected_card
          true
        else          
          SelectedCard.create! cube_id: self.id, card_id: card[:id], 
            architype_id: architype_id
        end
      end
    end
    true
  end
  
end
