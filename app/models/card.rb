class Card < ApplicationRecord
  
  has_many :selected_cards
  
  has_many :archetypes, through: :cardsets
  has_many :cardsets
  
  has_many :wishlists 
  has_many :cubes, through: :wishlists
    
  include PgSearch
  
  pg_search_scope :search_by_name, :against => :name, :using => { :tsearch => {:prefix => true} }
  
  def colors=(value)
    raise TypeError, "Expected Array and got #{value.class}" if not value.nil? and value.class != Array
    self.colors_list = value.to_json
  end
  
  def colors
    if self.colors_list == "null"
      return []
    end
    JSON self.colors_list
  end
  
  def types=(value)
    raise TypeError, "Expected Array and got #{value.class}" if not value.nil? and value.class != Array
    self.types_list = value.to_json
  end
  
  def types
    JSON self.types_list
  end
  
  def subtypes=(value)
    raise TypeError, "Expected Array and got #{value.class}" if not value.nil? and value.class != Array
    self.subtypes_list = value.to_json
  end
  
  def subtypes
    JSON self.subtypes_list
  end
  
  def fuse
    return nil if self.fuse_id.nil?
    card = Card.find(self.fuse_id)
    {
      id: card.id,
      name: card.name      
    }
  end
  
  def as_json(options = { })
      h = super(options)
      h[:fuse] = fuse
      h
  end
  
end
