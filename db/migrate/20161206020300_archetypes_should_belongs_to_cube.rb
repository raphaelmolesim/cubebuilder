class ArchetypesShouldBelongsToCube < ActiveRecord::Migration[5.0]
  def change
    create_table :archetypes_in_cube do |t|
      t.belongs_to :cube, index: true
      t.belongs_to :archetype, index: true
      t.timestamps  
    end    
  end
end