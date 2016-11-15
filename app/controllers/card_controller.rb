class CardController < ApplicationController
  
  def search    
    card_name = params[:card_name]    
    card = Card.where(name: card_name).first    
    
    if card
      render text: card.to_json
    else
      render text: ""
    end
  end
  
  def cube_load 
    cards_ids = params[:cards_ids]
    cube = {
      :Black => { :Spells => [], :Creatures => []},
      :Blue => { :Spells => [], :Creatures => []},
      :Red => { :Spells => [], :Creatures => []},
      :White => { :Spells => [], :Creatures => []},
      :Green => { :Spells => [], :Creatures => []},
      :Colorless => { :Spells => [], :Creatures => []},
      :Multicolor => { :Spells => [], :Creatures => []},
      :Land => []
    }
    
    Card.where(id: cards_ids).each do |item|
      color = nil
      
      if (item.types.include? "Land")
        cube[:Land] << item
        next
      end
      
      if item.colors.size == 1
        color = item.colors.first.to_sym
      elsif item.colors.size == 0
        color = :Colorless
      elsif item.colors.size > 1
        color = :Multicolor
      end
      
      if item.types.include? "Creature"
        cube[color][:Creatures] << item
      else
        cube[color][:Spells] << item
      end
    end
    
    render text: cube.to_json
  end
  
end
