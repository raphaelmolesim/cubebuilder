class AssignValueForAllArchetypeInCubes < ActiveRecord::Migration[5.0]
  def change
    archetypesByCube = ArchetypesInCube.all.inject({}) do |r, item|
      r[item.cube_id] ||= []
      r[item.cube_id] << item
      r
    end
    
    archetypesByCube.each do |cube_id, archetypes|
      archetypes.each_with_index do |item, index|
        item.cube_players = index
      end
    end
    
  end
end
