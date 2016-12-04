class Archetype < ApplicationRecord

  has_many :selected_cards
  
  has_many :cards, through: :cardsets
  has_many :cardsets
  
  def as_json(options = { })
      h = super(options)
      h[:cards_count] = selected_cards.size
      h[:cards] = cardsets.map { |s| s.card }
      h
  end

end
