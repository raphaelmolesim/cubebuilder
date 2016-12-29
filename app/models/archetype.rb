class Archetype < ApplicationRecord

  has_many :selected_cards
  
  has_many :cards, through: :cardsets
  has_many :cardsets
  
  has_many :cubes, through: :archetypes_in_cubes
  has_many :archetypes_in_cubes
  
  belongs_to :user
  
  validates_presence_of :user
  
  def as_json(options = { })
      h = super(options)
      h[:cards_count] = cardsets.size
      h[:cards] = cardsets.map { |s| s.card }
      h[:cube_ids] = cube_ids
      h[:cubes_config] = archetypes_in_cubes
      h
  end

end
