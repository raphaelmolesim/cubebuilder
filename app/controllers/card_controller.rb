class CardController < ApplicationController
  
  def show
    card = Card.where(id: params[:id]).first
    
    if card
      render text: card.to_json
    else
      render text: ""
    end
  end
  
  def search    
    card_name = params[:card_name]    
    card = Card.search_by_name(card_name).first    
    
    if card
      render text: card.to_json
    else
      render text: ""
    end
  end
  
  def cube_load 

    colors = [:Black, :Blue, :Red, :White, :Green, :Colorless, :Multicolor, :Land ]
    cube = colors.inject({}) { |r, item| r[item] = { :Spells => [], :Creatures => []} ; r }
    
    repetition = []
    
    SelectedCard.where(cube_id: params[:id]).each do |selected_card|
      next if (repetition.include? selected_card.card_id)
      
      repetition << selected_card.card_id
      item = selected_card.card
      
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
    
    cube.each { |color, map| map.each { |type, cards| cards.sort!{ |c1, c2| c1.cmc <=> c2.cmc } } }
    
    render text: cube.to_json
  end
  
end
