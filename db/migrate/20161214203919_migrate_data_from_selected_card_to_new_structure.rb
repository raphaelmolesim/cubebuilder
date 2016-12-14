class MigrateDataFromSelectedCardToNewStructure < ActiveRecord::Migration[5.0]
  def change
    Cardset.all.delete_all
    ArchetypesInCube.all.delete_all
    
    hashMap = SelectedCard.all.inject({}) do |r, selected_card|
      r[selected_card.cube_id] ||= {}
      r[selected_card.cube_id][selected_card.archetype_id] ||= []
      r[selected_card.cube_id][selected_card.archetype_id] << selected_card.card_id
      r
    end
    
    hashMap.each do |cube_id, archetypes|
      archetypes.each do |archetype_id, cards|
        puts "--> Cube #{cube_id} #{archetype_id} "
        archeIncube = ArchetypesInCube.new archetype_id: archetype_id, cube_id: cube_id
        next if not archeIncube.save
        cards.each do |card_id|
          puts "--> Cards #{archetype_id} #{card_id} "
          cardset = Cardset.new archetype_id: archetype_id, card_id: card_id
          next if not cardset.save
        end        
      end
    end 
       
  end
end
