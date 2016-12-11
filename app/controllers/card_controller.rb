class CardController < ApplicationController
  
  def show
    @card = Card.where(id: params[:id]).first
    respond_to { |format| format.json { render json: @card , status: :ok } }
  end
  
  def search    
    card_name = params[:card_name]    
    cards = Card.search_by_name(card_name).to_a
        
    if not cards.empty?
      render text: cards.to_json
    else
      render text: ""
    end
  end
  
  def cube_load 

    colors = [:Black, :Blue, :Red, :White, :Green, :Colorless, :Multicolor ]
    cube = colors.inject({}) { |r, item| r[item] = { :Spells => [], :Creatures => []} ; r }
    cube[:Land] = []
    summary = { Spells: {}, Creatures: {} }
    repetition = []
    
    SelectedCard.where(cube_id: params[:id]).each do |selected_card|
      next if (repetition.include? selected_card.card_id)
      
      repetition << selected_card.card_id
      item = selected_card.card
      
      color = nil
      
      if (item.types.include? "Land")
        cube[:Land] << item
        summary[:Land] ||= 0
        summary[:Land] += 1
        summary[:Cards] ||= 0
        summary[:Cards] += 1
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
        summary[:Creatures][color] ||= 0
        summary[:Creatures][color] += 1
        cube[color][:Creatures] << item
      else
        summary[:Spells][color] ||= 0
        summary[:Spells][color] += 1
        cube[color][:Spells] << item
      end
      
      summary[color] ||= 0
      summary[color] += 1
      summary[:Cards] ||= 0
      summary[:Cards] += 1
      
    end
    
    cube.each { |color, map| map.each { |type, cards| cards.sort!{ |c1, c2| c1.cmc <=> c2.cmc } } if color != :Land }
    cube[:Total] = summary
    
    render text: cube.to_json
  end
  
end
