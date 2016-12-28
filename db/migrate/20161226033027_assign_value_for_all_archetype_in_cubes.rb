class AssignValueForAllArchetypeInCubes < ActiveRecord::Migration[5.0]
  def change
    to_delete = []
    
    archetypesByCube = ArchetypesInCube.all.inject({}) do |r, item|
      r[item.cube_id] ||= []
      
      begin
        r[item.cube_id] << Archetype.find(item.archetype_id).cards
      rescue
        to_delete << item
      end
      r[item.cube_id].flatten!
      r[item.cube_id].uniq!
      
      players = (r[item.cube_id].size / 45.0).ceil
      
      players = 4 if players <= 4
      players += 1 if players.odd?
      item.cube_players = players
      item.save!
      
      r
    end
    
    ArchetypesInCube.where(:id => to_delete.map(&:id)).delete_all
  end
end
