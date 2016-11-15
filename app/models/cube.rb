class Cube < ApplicationRecord
  has_and_belongs_to_many :cards
  
  accepts_nested_attributes_for :cards, :allow_destroy => false
end
