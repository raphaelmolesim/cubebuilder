class ArchetypesInCube < ApplicationRecord

  belongs_to :cube
  belongs_to :archetype
  
  validates_uniqueness_of :cube_id, scope: [:cube_id, :archetype_id]
  validates_presence_of :cube_id, :archetype_id
end
