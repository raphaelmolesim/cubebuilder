class Cube < ApplicationRecord
  
  has_many :selected_cards
  
  has_many :wishlists 
  has_many :cubes, through: :wishlists 
  
  has_many :archetypes, through: :archetypes_in_cubes
  has_many :archetypes_in_cubes
  
  belongs_to :user
  
  validates_presence_of :user
  
  def sync_all_cube cube_list
    current_cards = selected_cards.to_a
    
    cube_list.each do |card|
      card[:archetypes].each do |archetype_id|
        selected_card = current_cards.detect { |c| 
          c.card_id == card[:id] && c.archetype_id == archetype_id  }
          current_cards -= [selected_card]
        if selected_card
          true
        else          
          SelectedCard.create! cube_id: self.id, card_id: card[:id], 
            archetype_id: archetype_id
        end
      end
    end
    
    current_cards.each { |card| card.delete }
    
    true
  end
  
end
