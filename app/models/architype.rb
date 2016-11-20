class Architype < ApplicationRecord

  has_many :selected_cards
  
  
  def as_json(options = { })
      h = super(options)
      h[:cards_count] = selected_cards.size
      h
  end

end
