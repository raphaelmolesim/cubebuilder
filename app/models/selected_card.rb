class SelectedCard < ApplicationRecord
  
  belongs_to :card, required: true
  belongs_to :cube, required: true
  belongs_to :archetype, required: true
  
  validates_uniqueness_of :card_id, :scope => [:cube_id, :archetype_id]
  validates_presence_of :card_id, :cube_id, :archetype_id
  
end
