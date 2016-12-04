class Cardset < ApplicationRecord
  
  belongs_to :card
  belongs_to :archetype
  
  validates_uniqueness_of :archetype_id, scope: [:card_id, :archetype_id]
  
end