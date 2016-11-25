class Cube < ApplicationRecord
  
  has_many :selected_cards
  
  has_many :wishlists 
  has_many :cubes, through: :wishlists 
  
  def sync_all_cube cube_list
    current_cards = selected_cards.to_a
    
    cube_list.each do |card|
      card[:architypes].each do |architype_id|
        selected_card = current_cards.detect { |c| 
          c.card_id == card[:id] && c.architype_id == architype_id  }
          current_cards -= [selected_card]
        if selected_card
          true
        else          
          SelectedCard.create! cube_id: self.id, card_id: card[:id], 
            architype_id: architype_id
        end
      end
    end
    
    current_cards.each { |card| card.delete }
    
    true
  end
  
end
