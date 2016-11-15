class Card < ApplicationRecord
  
  def colors=(value)
    raise TypeError, "Expected Array and got #{value.class}" if not value.nil? and value.class != Array
    self.colors_list = value.to_json
  end
  
  def colors
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
  
end
