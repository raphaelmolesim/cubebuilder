class Architype < ApplicationRecord

  has_many :selected_cards
  
  
  def as_json(options = { })
      h = super(options)
      h[:cards_count] = selected_cards.to_a.select { |s| s.cube_id == session[:cube_id] }.size
      h
  end

end
