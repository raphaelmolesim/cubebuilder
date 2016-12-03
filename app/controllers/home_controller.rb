class HomeController < ApplicationController
  def index
  end

  def row_data
    @selected_cards = Cube.find(session[:cube_id]).selected_cards
  end
  
  def restore_LocalStorage
    selected_cards = Cube.find(session[:cube_id]).selected_cards
    
    localStorage = []
    
    selected_cards.each do |item|
      card = item.card
      obj = localStorage.detect { |c| c[:id] == card.id }
      if obj
        obj[:archetypes] << item.archetype.id
      else
        localStorage << { id: card.id , archetypes: [item.archetype.id] }
      end      
    end
    
    respond_to do |format|
      format.json { render json: localStorage.to_json, status: :ok }
    end
  end
  
end
